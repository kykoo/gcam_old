#!/bin/bash

/usr/bin/gpio mode 27 in
/usr/bin/gpio mode 27 up

# Pin27   | Motion 
# Logic 0 = motion on
# Logic 1 = motion down


while true;
do      
    value=$(/usr/bin/gpio read 27)
    motion=$(/bin/systemctl is-active motion.service)

    if [[ $value == "0" && $motion == "inactive" ]]; then
	echo "starting motion.service"
	sudo /bin/systemctl start motion.service
    fi

    if [[ $value = "1" && $motion = "active" ]]; then
	echo "stopping motion.service"
	sudo /bin/systemctl stop motion.service
    fi

    sleep 1
done
