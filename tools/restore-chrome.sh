#!/bin/bash
echo "Restarting the following Chrome GPU processes:"
ps aux | grep gpu-process | grep -v grep | awk '{ print $2 " " $11 }'
exit 0
for i in $(ps aux | grep gpu-process | grep -v grep | awk '{ print $2 }')
do
    kill -TERM $i
done

