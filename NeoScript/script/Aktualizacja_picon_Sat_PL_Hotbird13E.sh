#!/bin/sh

#!/bin/sh
if `grep -q 'osd.language=pl_PL' </etc/enigma2/settings`; then
  PL=1
fi

LinkNeoList='https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/piconHB'
cd /tmp

echo "Script by - gutosie"
echo "*****************************************************"
[ $PL ] && echo "Pobieranie picon z sieci..." || echo "Downloading a picon from the web...";
sleep 2 
if [ -f /usr/bin/wget ] ; then
    echo "________________________________";
    sleep 2
    wget -q --no-check-certificate $LinkNeoList > /dev/null 2>&1
    if [ ! -f /tmp/piconHB ] ; then
       echo "wget nie potrafił pobrać picon"
       sleep 2
    fi
fi

if [ ! -f /tmp/piconHB ] ; then
    if [ -f /usr/bin/curl ] ; then
        echo "curl instaluje nowe picony"
        echo "________________________________"
        curl -O --ftp-ssl -k $LinkNeoList > /dev/null 2>&1
    else
       echo "curl nie potrafił pobrać picon - nie ma curl"
       sleep 2
    fi
fi

if [ ! -f /tmp/piconHB ] ; then
    if [ -f /usr/bin/fullwget ] ; then
        echo "Instalacja nowech picon w toku..."
        echo "________________________________"
        fullwget --no-check-certificate wget -q $LinkNeoList > /dev/null 2>&1
    else
       echo "fullwget nie potrafił pobrać picon - nie ma fullwget"
       sleep 2
    fi
fi

sleep 2

if [ -f /tmp/piconHB ] ; then
    [ $PL ] && echo "Loga kanałów pobrane prawidłowo" || echo "Picon lists downloaded";
    [ $PL ] && echo "Instalacja nowechy picon w toku..." || echo "Installing new picon in progress..." ;
    echo "________________________________" ;
    sleep 2
    /bin/tar -xzvf /tmp/piconHB -C / > /dev/null 2>&1;
    [ $PL ] && echo "Aktywacja picon dla listy kanałów..." || echo "Activating a new picon...";    
    sleep 1
    echo "________________________________" ;
    [ $PL ] && echo "Loga kanałów zaktualizowane" || echo "Picon updated successfully.";
    echo "________________________________";
    sleep 1
    [ $PL ] && echo "Usuwanie plik�w instalacyjnych..." || echo "Cleaning..."  ;
    rm -fr /tmp/piconHB
    echo "________________________________" ;
    sleep 1  
    [ $PL ] && echo "Należy uruchomić ponownie system enigma2" || echo "Restart the receiver.." ;
    sleep 1
    [ $PL ] && echo "Pozdrawiam - gutosie" || echo "Regards - gutosie" ;
    [ $PL ] && echo "K O N I E C" || echo "F I N I S H"
    echo "*****************************************************"
else
   echo "Picon niezaktualizowana !!!"
   echo "Nie można pobrać aktualizacji, spróbuj później..."
   echo `date`
fi

cd /

if [ -f /.wget-hsts ] ; then
    rm -f /.wget-hsts
    fi
exit 0
