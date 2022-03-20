#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/soc/11230000.mmc/by-name/recovery:12081152:4d39e1dd1be49dfe23605714dfa84b8c5a5c3276; then
  applypatch  EMMC:/dev/block/platform/soc/11230000.mmc/by-name/boot:6653952:c5989e8bdea659d2aefe4d9f74d3dfa9bb342ffb EMMC:/dev/block/platform/soc/11230000.mmc/by-name/recovery 6e5dea0a0a70e9b0625e930caf3a43fe749ea071 12079104 c5989e8bdea659d2aefe4d9f74d3dfa9bb342ffb:/system/recovery-from-boot.p && installed=1 && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  [ -n "$installed" ] && dd if=/system/recovery-sig of=/dev/block/platform/soc/11230000.mmc/by-name/recovery bs=1 seek=12079104 && sync && log -t recovery "Install new recovery signature: succeeded" || log -t recovery "Installing new recovery signature: failed"
else
  log -t recovery "Recovery image already installed"
fi
