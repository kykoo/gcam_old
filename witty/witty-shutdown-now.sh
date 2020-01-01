#!/bin/bash
# file: daemon.sh
#
# This script should be auto started, to support WittyPi hardware
#

# check if sudo is used
if [ "$(id -u)" != 0 ]; then
  echo 'Sorry, you need to run this script with sudo'
  exit 1
fi

# get current directory
cur_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# utilities
. "$cur_dir/utilities.sh"


# make sure the halt pin is input with internal pull up
gpio -g mode $HALT_PIN up
gpio -g mode $HALT_PIN in


# wait for RTC ready
sleep 2

# if RTC presents
is_rtc_connected
has_rtc=$?  # should be 0 if RTC presents

do_shutdown $HALT_PIN $LED_PIN $has_rtc
