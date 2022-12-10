#!/bin/sh

LinkNeoScript='https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/e2ListaHB.tar.gz'

if `grep -q 'osd.language=pl_PL' </etc/enigma2/settings`; then
  PL=1
fi

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
    wget -q $LinkNeoScript > /dev/null 2>&1
    if [ ! -f /tmp/e2ListaHB.tar.gz ] ; then
       echo "wget nie pobraĹ listy kanaĹ‚Ăłw"
       sleep 2
    fi
fi

if [ ! -f /tmp/e2ListaHB.tar.gz ] ; then
    if [ -f /usr/bin/curl ] ; then
        echo `date` "curl znaleziony"
        echo "Instalacja nowej listy kanaĹ‚Ăłw w toku..."
        echo "________________________________"
        curl -O --ftp-ssl -k $LinkNeoScript > /dev/null 2>&1
    else
       echo "curl nie pobraĹ‚ listy kanaĹ‚Ăłw - nie ma curl"
       sleep 2
    fi
fi

if [ ! -f /tmp/e2ListaHB.tar.gz ] ; then
    if [ -f /usr/bin/fullwget ] ; then
        echo "fullwget znaleziony"
        echo "Instalacja nowej listy kanaĹ‚Ăłw w toku..."
        echo "________________________________"
        fullwget --no-check-certificate wget -q $LinkNeoScript > /dev/null 2>&1
    else
       echo "fullwget nie pobraĹ‚ listy kanaĹ‚Ăłw nie ma fullwget"
       sleep 2
    fi
fi

sleep 2

if [ -f /tmp/e2ListaHB.tar.gz ] ; then
    [ $PL ] && echo "Listy kanaĹ‚Ăłw pobrana poprawnie" || echo "Channel lists downloaded";
    [ $PL ] && echo "Usuwanie starej listy kanaĹ‚Ăłw..." || echo "Deleting an old list...";
    echo "________________________________";
    sleep 2
    rm -fr /etc/enigma2/userbouquet*;
    rm -fr /etc/enigma2/bouquets*;
    [ $PL ] && echo "Instalacja nowej listy kanaĹ‚Ăłw w toku..." || echo "Installing new list in progress..." ;
    echo "________________________________" ;
    sleep 2
    /bin/tar -xzvf /tmp/e2ListaHB.tar.gz -C / > /dev/null 2>&1;
    [ $PL ] && echo "Aktywacja nowej listy kanaĹ‚Ăłw..." || echo "Activating a new list...";    
    sleep 1
    echo "________________________________" ;
    [ $PL ] && echo "Lista kanaĹ‚Ăłw zostaĹ‚a zaktualizowana." || echo "List updated successfully.";
    echo "________________________________";
    sleep 2
    wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 2>/dev/null ;
    wget -q -O /dev/null http://127.0.0.1/web/servicelistreload?mode=0 2>/dev/null ;
    [ $PL ] && echo "Usuwanie plikĂłw instalacyjnych..." || echo "Cleaning..."  ;
    sleep 2
    echo "________________________________" ;
    rm -fr /tmp/e2ListaHB.tar.gz
    [ $PL ] && echo "Nalezy uruchomic ponownie odbiornik ..." || echo "Restart the receiver.." ; #RestartujÄ™ EnigmÄ™...
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
cd /

exit 0
