#!/bin/bash
#set -x

#sudo macchanger -m 8c:c8:cd:**:**:** enp2s0
#sudo macchanger -e enp2s0
#sudo macchanger -e enp2s0
#sudo macchanger -e enp2s0
#
#exit
# n=1
#while(( $n < 20 ))
INTERFACES=$(ls /sys/class/net > /tmp/interfaces_list.file)
#echo "$INTERFACES"
while read INTERFACE
do
    if [ $INTERFACE != "lo" ]; then
        echo "Shutting down Interface $INTERFACE........."
        echo $(sudo ifconfig $INTERFACE down)
        #original_mac=$(sudo macchanger -s $INTERFACE)
        wait
        
        if [[ "$INTERFACE" =~ vm ]]; then
            #new_mac=$(sudo macchanger -s $INTERFACE)
            #while (( $original_mac -ne $new_mac ))
            #do
                echo "Changing MAC Address For Interface $INTERFACE........."
                echo $(sudo macchanger -e $INTERFACE)
                echo "....................................................................."
                echo $(sudo macchanger -e $INTERFACE)
                echo "....................................................................."
                echo $(sudo macchanger -e $INTERFACE)
                echo "....................................................................."
             #   new_mac=$(sudo macchanger -s $INTERFACE)
            #done
        else
            echo "Changing MAC Address of Interface $INTERFACE........."
            echo $(sudo macchanger -a $INTERFACE)
            echo "....................................................................."
            echo $(sudo macchanger -a $INTERFACE)
            echo "....................................................................."
            echo $(sudo macchanger -a $INTERFACE)
            echo "....................................................................."
        fi

        echo "Starting Interface $INTERFACE........."
        sudo ifconfig $INTERFACE up
        echo "=========================================================================="
        echo "=========================================================================="
        echo ""
    fi
done < /tmp/interfaces_list.file

exit 0
