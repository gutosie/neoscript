#!/bin/sh
if `grep -q 'osd.language=pl_PL' </etc/enigma2/settings`; then
  PL=1
fi

LinkNeoList='https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/e2listhb'
cd /tmp

#echo   `date +[%e-%m-%Y_%T]`;
echo "Script by - gutosie"
echo "*****************************************************"
[ $PL ] && echo "Pobieranie listy kanałów z sieci..." || echo "Downloading a list from the web...";
sleep 2 
if [ -f /usr/bin/wget ] ; then
    echo "________________________________";
    sleep 2
    #wget -q "--no-check-certificate" wget -O - -q
    wget -q --no-check-certificate $LinkNeoList > /dev/null 2>&1
    if [ ! -f /tmp/e2listhb ] ; then
       echo "wget nie potrafił pobrać listy kanałów"
       sleep 2
    fi
fi

if [ ! -f /tmp/e2listhb ] ; then
    if [ -f /usr/bin/curl ] ; then
        echo "curl instaluje nową listę kanałów"
        echo "________________________________"
        curl -O --ftp-ssl -k $LinkNeoList > /dev/null 2>&1
    else
       echo "curl nie potrafił pobrać listy kanałów - nie ma curl"
       sleep 2
    fi
fi

if [ ! -f /tmp/e2listhb ] ; then
    if [ -f /usr/bin/fullwget ] ; then
        echo "Instalacja nowej listy kanałów w toku..."
        echo "________________________________"
        fullwget --no-check-certificate wget -q $LinkNeoList > /dev/null 2>&1
    else
       echo "fullwget nie potrafił pobrać listy kanałów - nie ma fullwget"
       sleep 2
    fi
fi

sleep 2

if [ -f /tmp/e2listhb ] ; then
    [ $PL ] && echo "Listy kanałów pobrana prawidłowo" || echo "Channel lists downloaded";
    [ $PL ] && echo "Usuwanie starej listy kanałów..." || echo "Deleting an old list...";
    echo "________________________________";
    sleep 2
    rm -fr /etc/enigma2/userbouquet*;
    rm -fr /etc/enigma2/bouquets*;
    rm -fr /etc/enigma2/lamed*;
    [ $PL ] && echo "Instalacja nowej listy kanałów w toku..." || echo "Installing new list in progress..." ;
    echo "________________________________" ;
    sleep 2
    /bin/tar -xzvf /tmp/e2listhb -C / > /dev/null 2>&1;
    [ $PL ] && echo "Aktywacja nowej listy kanałów..." || echo "Activating a new list...";    
    sleep 1
    echo "________________________________" ;
    [ $PL ] && echo "Lista kanałów została zaktualizowana" || echo "List updated successfully.";
    echo "________________________________";
    sleep 2
    wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 2>/dev/null ;
    wget -q -O /dev/null http://127.0.0.1/web/servicelistreload?mode=0 2>/dev/null ;
    [ $PL ] && echo "Usuwanie plików instalacyjnych..." || echo "Cleaning..."  ;
    sleep 2
    echo "________________________________" ;
    rm -fr /tmp/e2listhb
    sed -i "2d" /etc/enigma2/settings
    sleep 1
    #sed -ie 's/config.servicelist.startupservice=/#/g' /etc/enigma2/settings
    echo "config.servicelist.startupservice=1:0:1:1139:2AF8:13E:820000:0:0:0:: TVP INFO HD" >> /etc/enigma2/settings; 
    echo "Ustwiono TVP INFO HD jako kanał startowy"    
    [ $PL ] && echo "Należy uruchomić ponownie system enigma2" || echo "Restart the receiver.." ;
    sleep 2
    [ $PL ] && echo "Pozdrawiam - gutosie" || echo "Regards - gutosie" ;
    [ $PL ] && echo "K O N I E C" || echo "F I N I S H"
#    echo  `date`
    echo "*****************************************************"
    #wget -q -s "http://127.0.0.1/web/message?text=Zaktualizowalem%20liste%20kanalow&type=1&timeout=5" 2>/dev/null
    #wget -O /dev/null -q "http://localhost/web/message?text=Aktualizacja...+Czekaj+na+kompletny+restart+systemu...%0AOperacja+w+toku...&type=2&timeout=05" 2>/dev/null  
else
   echo "Lista niezaktualizowana !!!"
   echo "Nie można pobrać aktualizacji, spróbuj później..."
   echo `date`
fi

echo "config.servicelist.startuproot=1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "bouquets.tv" ORDER BY bouquet;1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.dbe01.tv" ORDER BY bouquet" >> /etc/enigma2/settings' 
echo "config.servicelist.startupservice=1:0:1:1139:2AF8:13E:820000:0:0:0:" >> /etc/enigma2/settings'
cd /
if [ -f /etc/enigma2/settingse ] ; then
    rm -f /etc/enigma2/settingse
    fi

if [ -f /.wget-hsts ] ; then
    rm -f /.wget-hsts
    fi
exit 0
