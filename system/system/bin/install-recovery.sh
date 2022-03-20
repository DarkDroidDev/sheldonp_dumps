#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/soc/11230000.mmc/by-name/recovery:11964416:2d445022a310f5c563e723d7c9cd3249722d7289; then
  applypatch  EMMC:/dev/block/platform/soc/11230000.mmc/by-name/boot:6539264:83058faee4b66a6340d99707832f0fc5ec3555e9 EMMC:/dev/block/platform/soc/11230000.mmc/by-name/recovery 2d96c383ee4f97ef2978425bbccd9b6a904c9d00 11962368 83058faee4b66a6340d99707832f0fc5ec3555e9:/system/recovery-from-boot.p && installed=1 && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  [ -n "$installed" ] && dd if=/system/recovery-sig of=/dev/block/platform/soc/11230000.mmc/by-name/recovery bs=1 seek=11962368 && sync && log -t recovery "Install new recovery signature: succeeded" || log -t recovery "Installing new recovery signature: failed"
else
  log -t recovery "Recovery image already installed"
fi
