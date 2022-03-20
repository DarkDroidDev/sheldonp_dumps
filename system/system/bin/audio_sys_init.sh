#!/system/bin/sh

idme_device_type_id=`/system/bin/cat /proc/idme/device_type_id`
echo "audio_sys_init: device_type_id: $idme_device_type_id" > /dev/kmsg

#Sheldon
#In future use IDME /proc/idme/productid2 for 10/11/00/01 Sheldon-I/Sheldon-I+/Sheldon/Sheldon+
if [ $idme_device_type_id == "A31DTMEEVDDOIV" ] || [ $idme_device_type_id == "A265XOI9586NML" ]; then
        /system/bin/setprop vendor.init.svc.bootanim "running"
        # proxy hal enable/disable
        # proxy hal enable 1: enabled , 0: disabled
        /system/bin/setprop persist.audio.proxy.hal.enable 1
        # tunnel mode audio pts adjust
        /system/bin/setprop tunnelmode.raw.apts.adjust -52
        /system/bin/setprop tunnelmode.pcm.apts.adjust -63
        # BT Tunnelmode audio pts adjust
        /system/bin/setprop tunnelmode.bt.apts.adjust -170

        # Audio pts adjust for AV sync fine tuning in non tunnel mode in DMA
        /system/bin/setprop apts_tune.non_tunnel_pcm -50
        /system/bin/setprop apts_tune.non_tunnel_dlb 25
        /system/bin/setprop apts_tune.non_tunnel_bt -180

        # AVLS specific usecase tuning, no impact on regular hdmi playback
        /system/bin/setprop apts_tune.non_tunnel.avls 190
        /system/bin/setprop apts_tune.tunnel.avls -140
else
        echo "audio_sys_init: unknown device_type_id - $idme_device_type_id" > /dev/kmsg
fi

