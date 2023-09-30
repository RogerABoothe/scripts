#Created off ITSM-28, see it for BRD
#!/bin/bash

. /mnt/pool-01/coderepos/scripts/torrent_dev.config
SOURCE="${CONFIG_SOURCE//$'\r'}"
WATCH="${CONFIG_WATCH//$'\r'}"
LOG="${CONFIG_LOG//$'\r'}"

cd $SOURCE

find ./ -type f -mmin -10  -exec cp -pf {} $WATCH \;

