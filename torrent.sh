#Created off ITSM-28, see it for BRD
#!/bin/bash

if [ "$USER" = "cron" ]
then
    . /mnt/pool-02/configs/torrent.config
else
    . /mnt/pool-01/coderepos/scripts/torrent_dev.config
fi

SOURCE="${CONFIG_SOURCE//$'\r'}"
WATCH="${CONFIG_WATCH//$'\r'}"
LOG="${CONFIG_LOG//$'\r'}"

FILE_COUNT=$(find $SOURCE -type f -amin -5 | wc -l)

if [[ $FILE_COUNT -gt 0 ]]
then
    echo "Process started!" $(date "+%Y-%m-%d %H-%M-%S")>> $LOG
    echo "Moving" $FILE_COUNT "files" >> $LOG
    find $SOURCE -type f -amin -5 >> $LOG
    find $SOURCE -type f -amin -5  -exec cp -pf {} $WATCH \;
    echo "Process ended!" $(date "+%Y-%m-%d %H-%M-%S") >> $LOG
fi