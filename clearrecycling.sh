#Created off ITSM-28, see it for BRD
#!/bin/bash
# -atime +14 | -amin -5

if [ "$USER" = "cron" ]
then
    . /mnt/pool-02/configs/recycling.config
else
    . /mnt/pool-01/coderepos/scripts/recycling_dev.config
fi

LOG="${CONFIG_LOG//$'\r'}"
echo "Process started!" $(date "+%Y-%m-%d %H-%M-%S")>> $LOG
POOL_COUNT=1

while [ $POOL_COUNT -le 11 ]
do

    if [[ $POOL_COUNT -le 9 ]]
    then
        FULL_PATH="/mnt/pool-0"$POOL_COUNT"/.recycle/"
    else
        FULL_PATH="/mnt/pool-"$POOL_COUNT"/.recycle/"
    fi

    #FULL_PATH=$POOL_NAME"/.recycle/"
    FILE_COUNT=$(find $FULL_PATH -type f -atime +14 | wc -l)

    if [[ $FILE_COUNT -gt 0 ]]
    then
        echo "Files found on " $FULL_PATH "starting delete of " $FILE_COUNT "files" >> $LOG
        find $FULL_PATH -atime +14 >> $LOG
        find $FULL_PATH -atime +14 -exec rm -rf '{}' \;
    else
        echo "No files found on" $FULL_PATH "to delete" >> $LOG
    fi

    POOL_COUNT=$(( $POOL_COUNT + 1 ))

done

echo "Process ended!" $(date "+%Y-%m-%d %H-%M-%S") >> $LOG