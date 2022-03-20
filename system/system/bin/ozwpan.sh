#!/system/bin/sh

rmmod ozwpan
insmod /system/lib/modules/ozwpan.ko g_net_dev=$(getprop wlan.interface.p2p.group)
restorecon /sys/devices/virtual/ozmo_wpan/ozwpan/select
restorecon /sys/devices/virtual/ozmo_wpan/ozwpan/mode
restorecon /sys/devices/virtual/ozmo_wpan/ozwpan/devices

readonly OZWPAN_DEV_FILE="/dev/ozwpan"
readonly OZWPAN_SELECT_FILE="/sys/class/ozmo_wpan/ozwpan/select"
readonly OZWPAN_MODE_FILE="/sys/class/ozmo_wpan/ozwpan/mode"
readonly OZWPAN_DEVICE_FILE="/sys/class/ozmo_wpan/ozwpan/devices"
PATH=/sbin:/system/sbin:/system/bin:/system/xbin

while [ 1 ]; do
    if [ -e ${OZWPAN_DEV_FILE} ]; then
        chown root:amz_group ${OZWPAN_DEV_FILE} ${OZWPAN_SELECT_FILE} ${OZWPAN_MODE_FILE} ${OZWPAN_DEVICE_FILE}
        chmod 0660 ${OZWPAN_DEV_FILE} ${OZWPAN_SELECT_FILE} ${OZWPAN_MODE_FILE} ${OZWPAN_DEVICE_FILE}
        break
    else
        sleep 1
    fi
done
