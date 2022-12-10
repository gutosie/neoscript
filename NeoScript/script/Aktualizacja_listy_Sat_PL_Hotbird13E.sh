#!/bin/sh

if `grep -q 'osd.language=pl_PL' </etc/enigma2/settings`; then
  PL=1
fi

cd /tmp

#echo   `date +[%e-%m-%Y_%T]`;
echo "Script by - gutosie"
echo "*****************************************************"

sleep 2 
if [ -f /usr/bin/wget ] ; then
    [ $PL ] && echo "Pobieranie listy kanałów z sieci..." || echo "Downloading a list from the web...";
    echo "________________________________";
    sleep 2
    #wget -q "--no-check-certificate" wget -O - -q
    wget -q https://raw.githubusercontent.com/gutosie/neoboot/master/e2ListaHB.tar.gz > /dev/null 2>&1
    sleep 2
    if [ -f /tmp/e2ListaHB.tar.gz ] ; then
        [ $PL ] && echo "Lista kanałów pobrana poprawnie." || echo "List downloaded successfully.";
    else
       echo "wget nie pobral listy kanałów - Lista niezaktualizowana !!!"
    fi
fi

if [ ! -f /tmp/e2ListaHB.tar.gz ] ; then
    if [ -f /usr/bin/curl ] ; then
        echo `date` "curl znaleziony"
        echo "Instalacja nowej listy kanałów w toku..."
        echo "________________________________"
        curl -O --ftp-ssl https://raw.githubusercontent.com/gutosie/neoboot/master/e2ListaHB.tar.gz > /dev/null 2>&1
    else
       echo "nie ma curl - lista niezaktualizowana"
    fi
fi

if [ ! -f /tmp/e2ListaHB.tar.gz ] ; then
    if [ -f /usr/bin/fullwget ] ; then
        echo "fullwget znaleziony"
        echo "Instalacja nowej listy kanałów w toku..."
        echo "________________________________"
        fullwget --no-check-certificate https://raw.githubusercontent.com/gutosie/neoboot/master/e2ListaHB.tar.gz > /dev/null 2>&1
    else
       echo "nie ma fullwget - lista niezaktualizowana"
    fi
fi

sleep 2

if [ -f /tmp/e2ListaHB.tar.gz ] ; then
    [ $PL ] && echo "Usuwanie starej listy kanałów..." || echo "Deleting an old list...";
    echo "________________________________";
    sleep 2
    rm -fr /etc/enigma2/userbouquet*;
    rm -fr /etc/enigma2/bouquets*;
    [ $PL ] && echo "Instalacja nowej listy kanałów w toku..." || echo "Installing new list in progress..." ;
    echo "________________________________" ;
    sleep 2
    /bin/tar -xzvf /tmp/e2ListaHB.tar.gz -C / > /dev/null 2>&1;
    [ $PL ] && echo "Lista kanałów została zaktualizowana." || echo "List updated successfully.";
    sleep 1
    echo "________________________________" ;
    [ $PL ] && echo "Aktywacja nowej listy kanałów..." || echo "Activating a new list...";
    echo "________________________________";
    sleep 2
    wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 2>/dev/null ;
    wget -q -O /dev/null http://127.0.0.1/web/servicelistreload?mode=0 2>/dev/null ;
    [ $PL ] && echo "Usuwanie plików instalacyjnych..." || echo "Cleaning..."  ;
    sleep 2
    echo "________________________________" ;
    rm -fr /tmp/e2ListaHB.tar.gz
    [ $PL ] && echo "Nalezy uruchomic ponownie odbiornik ..." || echo "Restart the receiver.." ; #Restartuję Enigmę...
    sleep 2
    [ $PL ] && echo "Pozdrawiam - gutosie" || echo "Regards - gutosie" ;
    [ $PL ] && echo "K O N I E C" || echo "F I N I S H"
#    echo  `date`
    echo "*****************************************************"
    #wget -q -s "http://127.0.0.1/web/message?text=Zaktualizowalem%20liste%20kanalow&type=1&timeout=5" 2>/dev/null
    #wget -O /dev/null -q "http://localhost/web/message?text=Aktualizacja...+Czekaj+na+kompletny+restart+systemu...%0AOperacja+w+toku...&type=2&timeout=05" 2>/dev/null  
else
   echo "Lista niezaktualizowana !!!"    `date`
   echo "Nie można pobrać aktualizacji, spróbuj później..."
fi
cd /

exit 0