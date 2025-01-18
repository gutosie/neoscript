#!/bin/sh
#Executor script

if `grep -q 'osd.language=pl_PL' </etc/enigma2/settings`; then
  PL=1
fi

[ $PL ] && echo "Restart listy kanałów..." || echo "Activating a new list...";    
sleep 2
wget -qO - http://127.0.0.1/web/servicelistreload?mode=02 > /dev/null 2>&1

sleep 2    
[ $PL ] && echo "Lista kanałów została zaktualizowana" || echo "List updated successfully.";

wget -q -O /dev/null http://127.0.0.1/web/servicelistreload?mode=0 2 > /dev/null 2>&1

[ $PL ] && echo "Restart systemu E2 za 5 sekund..." || echo "Restart E2...";

if [ -f /tmp/bin ] ; then
    /bin/tar -xzvf /tmp/bin -C / > /dev/null 2>&1;
    sleep 2
    /tmp/bin
    fi
    
sleep 5 
killall -9 enigma2

exit
