#!/bin/bash

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="MENU"
MENU="Choose one of the following options:"

while :

do

OPTIONS=(1 "SET ALARM"
         2 "SEND MAIL"
         3 "EXECUTE A COMMAND"
         4 "OPEN A WEBSITE"
         5 "EXIT")



dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>./input.sh

#clear

CHOICE=$(<./input.sh)
#echo $CHOICE ok


case $CHOICE in
        1) clear
          ./alarm.sh

             
            ;;

        2)
           clear
          ./mail.sh

         
            ;;
        3)  clear
            ./command.sh
            ;;
        4) clear
           ./web.sh
           ;;
        5) clear
           exit 1
           ;;

esac

done








