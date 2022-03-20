#!/vendor/bin/sh

idme_device_type_id=`/vendor/bin/cat /proc/idme/device_type_id`
echo "devcfg: device_type_id: $idme_device_type_id" > /dev/kmsg

#Sheldon
if [ $idme_device_type_id == "A31DTMEEVDDOIV" ] || [ $idme_device_type_id == "A265XOI9586NML" ]; then
        /vendor/bin/setprop ro.vendor.nrdp.modelgroup FIRETVSTICKPLUS2020
        /vendor/bin/setprop ro.vendor.nrdp.validation ninja_7
else
        echo "devcfg: unknown device_type_id - $idme_device_type_id" > /dev/kmsg
fi

