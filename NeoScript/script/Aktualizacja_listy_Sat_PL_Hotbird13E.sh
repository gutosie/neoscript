#!/bin/sh
#tar -czf /tmp/e2listhb.tar.gz /usr/share/enigma2/picon/* /etc/enigma2/bouquets* /etc/enigma2/lamedb* /etc/enigma2/userbouquet.dbe* /etc/enigma2/satellites.xml /etc/tuxbox/satellites.xml /userbouquet.favourites*

if `grep -q 'osd.language=pl_PL' </etc/enigma2/settings`; then
  PL=1
fi

LinkNeoList='https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/e2listhb'
cd /tmp

#echo   `date +[%e-%m-%Y_%T]`;
echo "Script by - gutosie"
echo "*****************************************************"
[ $PL ] && echo "Pobieranie listy kanaĹ‚Ăłw z sieci..." || echo "Downloading a list from the web...";
sleep 2 
if [ -f /usr/bin/wget ] ; then
    echo "________________________________";
    sleep 2
    #wget -q "--no-check-certificate" wget -O - -q
    wget -q $LinkNeoList > /dev/null 2>&1
    if [ ! -f /tmp/e2listhb ] ; then
       echo "wget nie potrafiĹ‚ pobraÄ‡ listy kanaĹ‚Ăłw"
       sleep 2
    fi
fi

if [ ! -f /tmp/e2listhb ] ; then
    if [ -f /usr/bin/curl ] ; then
        echo "curl instaluje nowÄ… listÄ™ kanaĹ‚Ăłw"
        echo "________________________________"
        curl -O --ftp-ssl -k $LinkNeoList > /dev/null 2>&1
    else
       echo "curl nie potrafiĹ‚ pobraÄ‡ listy kanaĹ‚Ăłw - nie ma curl"
       sleep 2
    fi
fi

if [ ! -f /tmp/e2listhb ] ; then
    if [ -f /usr/bin/fullwget ] ; then
        chmod 755 /usr/bin/fullwget
        echo "Instalacja nowej listy kanaĹ‚Ăłw w toku..."
        echo "________________________________"
        fullwget --no-check-certificate wget -q $LinkNeoList > /dev/null 2>&1
    else
       echo "fullwget nie potrafiĹ‚ pobraÄ‡ listy kanaĹ‚Ăłw - nie ma fullwget"
       sleep 2
    fi
fi

sleep 2

if [ -f /tmp/e2listhb ] ; then
    [ $PL ] && echo "Lista kanaĹ‚Ăłw pobrana prawidĹ‚owo" || echo "Channel lists downloaded";
    [ $PL ] && echo "Usuwanie starej listy kanaĹ‚Ăłw..." || echo "Deleting an old list...";
    echo "________________________________";
    sleep 2
    rm -fr /etc/enigma2/userbouquet*;
    rm -fr /etc/enigma2/bouquets*;
    [ $PL ] && echo "Instalacja nowej listy kanaĹ‚Ăłw w toku..." || echo "Installing new list in progress..." ;
    echo "________________________________" ;
    sleep 2
    /bin/tar -xzvf /tmp/e2listhb -C / > /dev/null 2>&1;
    [ $PL ] && echo "Aktywacja nowej listy kanaĹ‚Ăłw..." || echo "Activating a new list...";    
    sleep 1
    echo "________________________________" ;
    [ $PL ] && echo "Lista kanaĹ‚Ăłw zostaĹ‚a zaktualizowana" || echo "List updated successfully.";
    echo "________________________________";
    sleep 2
    wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 2>/dev/null ;
    wget -q -O /dev/null http://127.0.0.1/web/servicelistreload?mode=0 2>/dev/null ;
    [ $PL ] && echo "Usuwanie plikĂłw instalacyjnych..." || echo "Cleaning..."  ;
    sleep 2
    echo "________________________________" ;
    rm -fr /tmp/e2listhb
    [ $PL ] && echo "NaleĹĽy uruchomiÄ‡ ponownie system enigma2" || echo "Restart the receiver.." ;
    sleep 2
    [ $PL ] && echo "Pozdrawiam - gutosie" || echo "Regards - gutosie" ;
    [ $PL ] && echo "K O N I E C" || echo "F I N I S H"
#    echo  `date`
    echo "*****************************************************"
    #wget -q -s "http://127.0.0.1/web/message?text=Zaktualizowalem%20liste%20kanalow&type=1&timeout=5" 2>/dev/null
    #wget -O /dev/null -q "http://localhost/web/message?text=Aktualizacja...+Czekaj+na+kompletny+restart+systemu...%0AOperacja+w+toku...&type=2&timeout=05" 2>/dev/null  
else
   echo "Lista niezaktualizowana !!!"
   echo "Nie moĹĽna pobraÄ‡ aktualizacji, sprĂłbuj pĂłĹşniej..."
   echo `date`
fi
cd

exit 0
