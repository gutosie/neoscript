#!/bin/sh
#Executor script

if `grep -q 'osd.language=pl_PL' </etc/enigma2/settings`; then
  PL=1
fi

[ $PL ] && echo "Restart listy kanałów..." || echo "Activating a new list...";    
sleep 2
wget -qO - http://127.0.0.1/web/servicelistreload?mode=02 >/dev/null >/dev/null

sleep 2    
[ $PL ] && echo "Lista kanałów została zaktualizowana" || echo "List updated successfully.";

wget -q -O /dev/null http://127.0.0.1/web/servicelistreload?mode=0 2 >/dev/null

[ $PL ] && echo "Restart systemu E2 za 5 sekund..." || echo "Restart E2...";

sleep 5 
killall -9 enigma2

exit