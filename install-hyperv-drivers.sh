#!/bin/bash

apt-get install -y linux-tools-virtual linux-cloud-tools-virtual
if [ $? -ne 0 ]; then
	echo Please fix the apt errors before re-running this script.
	exit 1
fi

#echo Now edit /etc/initramfs-tools/modules and make sure the following values are present:
#echo hv_vmbus
#echo hv_storvsc
#echo hv_blkvsc
#echo hv_netvsc
#echo Then reboot. Check whether it worked by:
#echo lsmod | grep hv

# Update hyper-v drivers
declare -a hvs=("hv_vmbus" "hv_storvsc" "hv_blkvsc" "hv_netvsc")

MODIFIEDCOUNT=0
if [ "$INITRAMFSCFG" == "" ]; then
	INITRAMFSCFG=/etc/initramfs-tools/modules
fi

for hv in "${hvs[@]}"
do
	ENTRY=$(grep "$hv" $INITRAMFSCFG)
	if [ "$ENTRY" == "" ]; then
		# append it
		echo "Missing $hv - adding"
		echo "$hv" >> $INITRAMFSCFG
		if [ $? -ne 0 ]; then
			echo Failed to add an entry. Are you running elevated?
			exit 1
		fi
		MODIFIEDCOUNT=$(($MODIFIEDCOUNT+1))
	fi
done
echo "Added $MODIFIEDCOUNT entries."

# Update grub video driver
REZ="1650x1050"

if [ "$GRUBCFG" == "" ]; then
	GRUBCFG=/etc/default/grub
fi
GRUBVIDEO=$(grep "^GRUB_CMDLINE_LINUX_DEFAULT=.*video=.*" $GRUBCFG)
if [ "$GRUBVIDEO" == "" ]; then
	echo "Configuring video resolution..."
	GRUBVIDEO=$(grep "^GRUB_CMDLINE_LINUX_DEFAULT=" $GRUBCFG)
	if [ "$GRUBVIDEO" == "" ]; then
		echo "GRUB_CMDLINE_LINUX_DEFAULT=\"video=hyperv_fb:$REZ\"" >> $GRUBCFG
	else
		sed -i -e "s/^GRUB_CMDLINE_LINUX_DEFAULT=\"\(.*\)\"$/GRUB_CMDLINE_LINUX_DEFAULT=\"\1 video=hyperv_fb:${REZ}\"/g" $GRUBCFG
	fi
	if [ $? -ne 0 ]; then
		echo Failed to configure resolution.
		exit 1
	fi
	MODIFIEDCOUNT=$(($MODIFIEDCOUNT+1))
	sudo update-grub
else
	echo "Grub video resolution already configured."
fi

echo "** NOTE **"
echo "Check the following files are all correct:"
echo "  $GRUBCFG"
echo "  $INITRAMFSCFG"


if [ $MODIFIEDCOUNT -ne 0 ]; then
	echo "You need to reboot now"
fi


