#!/bin/bash

# A simple alarm clock script

echo "What time should the alarm go off? (HH:MM)"
read target
 echo "enter the snoozing time in minutes"
    read $snooze
    snooze=`dc -e "$snooze 60 *p"`

# sleep interval is 15 minutes
#snooze=`dc -e "15 60 *p"`

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

echo "The alarm will go off at $target."
t=$(($sec_until -1))
#sleep $sec_until 
date1=`date +%s`
 while(($t!=0))
 do
 echo "COUNTDOWN" | toilet     
# echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r" | toilet -f mono12 -F metal 
 echo "$t" | toilet -f mono12 -F metal
sleep 1
t=$(($t-1))
clear
 done
# snooze loop


while :
do
  echo -e "\nWake up!"
  ./buzzer.sh & 
  bpid=$!
  disown $bpid                          # eliminates termination message
  echo "press Q to stop and any other key to snooze"
  read -n1 input
  for bsub in $(ps -o pid,ppid -ax | \
                awk "{ if (\$2 == $bpid) { print \$1 }}")
  do
    kill $bsub                          # kill children
  done
  kill $bpid
  if [ "$input" == "Q" ]
  then
    echo -e "\n"
     toilet -f mono12 -F metal Good
     toilet -f mono12 -F metal Morning
     sleep 5
     exit
  else
    echo -e "\nSnoozing for $snooze seconds..."
    sleep $snooze
  fi
done


