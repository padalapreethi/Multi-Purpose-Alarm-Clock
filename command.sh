#!/bin/bash

# mail script

echo "When do you want to execute the command ? (HH:MM)"
read target
echo "Enter the command"
read sub

# sleep interval is 15 minutes
snooze=`dc -e "15 60 *p"`

# convert wakeup time to seconds
target_h=`echo $target | awk -F: '{print $1}'`
target_m=`echo $target | awk -F: '{print $2}'`
target_s_t=`dc -e "$target_h 60 60 ** $target_m 60 *+p"`

# get current time and convert to seconds
clock=`date | awk '{print $4}'`
clock_h=`echo $clock | awk -F: '{print $1}'`
clock_m=`echo $clock | awk -F: '{print $2}'`
clock_s=`echo $clock | awk -F: '{print $3}'`
clock_s_t=`dc -e "$clock_h 60 60 ** $clock_m 60 * $clock_s ++p"`

# calculate difference in times, add number of sec. in day and mod by same
sec_until=`dc -e "24 60 60 **d $target_s_t $clock_s_t -+r%p"`

echo "The command will be executed at $target."

sleep $sec_until

# snooze loop

  echo `$sub`
sleep 5  
  
  




