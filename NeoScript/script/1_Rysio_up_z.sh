#!/bin/sh

Tesera=325
Dio=f4b62
Tria=a53b
Ena=a0cb
Miden=$Ena$Dio$Tria$Tesera


CHECKHOST=`cat /etc/hostname`
CHECK='/tmp/check'
uname -m > $CHECK


sleep 1;

if grep -wq "cpXalkidonaRysio" "/etc/tuxbox/config/oscam/oscam.server"; then
        echo "[ jest takie slowo w pliku ]"
        zerotier-cli info > /tmp/zerotier_cli

        zerotier-cli join $Miden

        sleep 2;

        /etc/init.d/zerotier reload

else
        echo "[ niema takiego slowa w pliku ]"
fi

exit 0