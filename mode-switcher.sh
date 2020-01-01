#!/bin/bash

/usr/bin/gpio mode 27 in
/usr/bin/gpio mode 27 up

while true;
do      
    value=$(/usr/bin/gpio read 27)
    motion=$(/bin/systemctl is-active motion.service)

    if [[ $value == "1" && $motion == "inactive" ]]; then
	echo "starting motion.service"
	sudo /bin/systemctl start motion.service
    fi

    if [[ $value = "0" && $motion = "active" ]]; then
	echo "stopping motion.service"
	sudo /bin/systemctl stop motion.service
    fi

    sleep 1
done
