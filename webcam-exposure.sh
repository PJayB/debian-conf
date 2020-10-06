#v4l2-ctl --set-ctrl exposure_absolute=21
#v4l2-ctl --set-ctrl brightness=30
EXP=${1:-200}
v4l2-ctl --set-ctrl exposure_auto=1
v4l2-ctl --set-ctrl exposure_absolute=20
v4l2-ctl --set-ctrl brightness=$EXP
