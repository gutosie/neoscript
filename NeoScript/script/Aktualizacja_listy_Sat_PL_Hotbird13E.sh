#!/bin/sh
if `grep -q 'osd.language=pl_PL' </etc/enigma2/settings`; then
  PL=1
fi

cd /tmp

CHECKHOST=`cat /etc/hostname`
CHECK='/tmp/check'
uname -m > $CHECK

sleep 1;

if [ ! -f /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/script/Aktualizacja_Listy_Sat_PL_Online.sh ] ; then
        rm -f /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/script/Aktualizacja_Listy_Sat_PL_Online.sh
fi

#grep -wq -i 'mips' cat $CHECK ||
#grep -wq -i 'armv7l' cat $CHECK ||

if grep -qs -i 'sh4' cat $CHECK ; then
           echo "[ Twoje STB to: sh4 ]" $CHECKHOST
           e2lista=e2listhb

elif grep -wq -i "osnino" "/etc/hostname" ||
           grep -wq -i "dm8000" "/etc/hostname" ||
           grep -wq -i 'osninoplus' "/etc/hostname"  ; then
           
           echo " Twoje STB to: MIPS" $CHECKHOST
           e2lista=e2iptvhb
             
elif grep -wq -i "zgemmah9twin" "/etc/hostname" ||         
           grep -wq -i "h9combo" "/etc/hostname" ||
           grep -wq -i "zgemmah82h" "/etc/hostname" ||
           grep -wq -i "h9se" "/etc/hostname" ||
           grep -wq -i "h8" "/etc/hostname" ||
           grep -wq -i "ustym4kpro" "/etc/hostname" ||
           grep -wq -i "protek4kx1" "/etc/hostname" ||        
           grep -wq -i "osmio4k" "/etc/hostname" ||
           grep -wq -i "lunix4k" "/etc/hostname" || 
           grep -wq -i "hitube4k" "/etc/hostname" ||        
           grep -wq -i "axashistwin" "/etc/hostname" ||
           grep -wq -i "bre2ze4k" "/etc/hostname" ||
           grep -wq -i "vuultimo4k" "/etc/hostname" ||
           grep -wq "vuduo4k" "/etc/hostname"  ; then
           
           echo " Twoje STB to: armv7l" $CHECKHOST
           e2lista=e2iptvhb    

else
           echo "Twoje STB to" $CHECKHOST
           e2lista=e2listhb
fi

LinkNeoList=https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/$e2lista

#echo   `date +[%e-%m-%Y_%T]`;
echo "Script by - gutosie"
echo "*****************************************************"
[ $PL ] && echo "Pobieranie listy kanałów z sieci..." || echo "Downloading a list from the web...";
sleep 2 
if [ -f /usr/bin/wget ] ; then
    echo "________________________________";
    sleep 2
    #wget -q "--no-check-certificate" wget -O - -q
    wget -q --no-check-certificate https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/$e2lista > /dev/null 2>&1
    if [ ! -f /tmp/$e2lista ] ; then
       echo "wget nie potrafił pobrać listy kanałów"
       sleep 2
    fi
fi

if [ ! -f /tmp/$e2lista ] ; then
    if [ -f /usr/bin/curl ] ; then
        echo "curl instaluje nową listę kanałów"
        echo "________________________________"
        curl -O --ftp-ssl -k https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/$e2lista > /dev/null 2>&1
    else
       echo "curl nie potrafił pobrać listy kanałów - nie ma curl"
       sleep 2
    fi
fi

if [ ! -f /tmp/$e2lista ] ; then
    if [ -f /usr/bin/fullwget ] ; then
        echo "Instalacja nowej listy kanałów w toku..."
        echo "________________________________"
        fullwget --no-check-certificate wget -q https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/$e2lista > /dev/null 2>&1
    else
       echo "fullwget nie potrafił pobrać listy kanałów - nie ma fullwget"
       sleep 2
    fi
fi

sleep 5

if [ -f /tmp/$e2lista ] ; then
    [ $PL ] && echo "Listy kanałów pobrana prawidłowo" || echo "Channel lists downloaded";
    [ $PL ] && echo "Usuwanie starej listy kanałów..." || echo "Deleting an old list...";
    echo "________________________________";
    sleep 2
    rm -fr /etc/enigma2/userbouquet*;
    rm -fr /etc/enigma2/bouquets*;
    rm -fr /etc/enigma2/lamed*;
    if [ -f /etc/enigma2/satellites.xml ] ; then
            rm -fr /etc/enigma2/satellites.xml;
    fi    
    [ $PL ] && echo "Instalacja nowej listy kanałów w toku..." || echo "Installing new list in progress..." ;
    echo "________________________________" ;
    sleep 2
    /bin/tar -xzvf /tmp/$e2lista -C / > /dev/null 2>&1;
    [ $PL ] && echo "Aktywacja nowej listy kanałów..." || echo "Activating a new list...";    
    sleep 1
    echo "________________________________" ;
    [ $PL ] && echo "Lista kanałów została zaktualizowana" || echo "List updated successfully.";
    echo "________________________________";
    sleep 2
    wget -q -O /dev/null http://127.0.0.1/web/servicelistreload?mode=0  > /dev/null 2>&1 ;
    wget -qO - http://127.0.0.1/web/servicelistreload?mode=0  > /dev/null 2>&1 ;
    [ $PL ] && echo "Usuwanie plików instalacyjnych..." || echo "Cleaning..."  ;
    sleep 2
    echo "________________________________" ;
    rm -fr /tmp/$e2lista
fi

sleep 2

/home/root/listaUser.sh  > /dev/null 2>&1

[ $PL ] && echo "Należy uruchomić ponownie system enigma2" || echo "Restart the receiver.." ;
sleep 2
[ $PL ] && echo "Pozdrawiam - gutosie" || echo "Regards - gutosie" ;
[ $PL ] && echo "K O N I E C" || echo "F I N I S H"
exit 0
