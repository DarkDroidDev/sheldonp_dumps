#!/system/bin/sh

/system/bin/setprop vendor.init.svc.bootanim "stopped"
echo "boot_complete:  ${vendor.init.svc.bootanim}" > /dev/kmsg

