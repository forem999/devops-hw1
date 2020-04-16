#!/bin/bash
now=$(date +"%Y%m%d%H%M%S")
nows=$(date +"%s")
let deltime=nows-3800
IFS=' '

ls -ogG --time-style=+"%s" | grep config | while read line
do
 read -ra ADDR <<< $line
 cp ${ADDR[4]} ./backup/"$now"_${ADDR[4]}
done

ls -ogG --time-style=+"%s" ./backup | grep config | while read line
do
 read -ra ADDR <<< $line
 if [ "${ADDR[3]}" -lt "$deltime" ]
 then
  rm ./backup/${ADDR[4]}
 fi
done

# run script evey hour in crontab -e
# * 0-23 * * * /home/forem/bashscr/test1/script.sh
