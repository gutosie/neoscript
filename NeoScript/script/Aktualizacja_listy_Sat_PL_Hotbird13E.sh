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
           grep -wq -i 'osninoplus' "/etc/hostname"  ; then
           
           echo " Twoje STB to: MIPS" $CHECKHOST
           e2lista=e2iptvhb
             
elif grep -wq -i "zgemmah9twin" "/etc/hostname" ||     
           grep -wq -i "h9combo" "/etc/hostname" ||
           grep -wq -i "h9se" "/etc/hostname" ||
           grep -wq -i "h8" "/etc/hostname" ||
           grep -wq -i "ustym4kpro" "/etc/hostname" ||
           grep -wq -i "protek4kx1" "/etc/hostname" ||    
           grep -wq -i "osmio4k" "/etc/hostname" ||
           grep -wq -i "lunix4k" "/etc/hostname" ||
           grep -wq -i "ixusszero" "/etc/hostname" ||
           grep -wq -i "hitube4k" "/etc/hostname" ||       
           grep -wq -i "axashistwin" "/etc/hostname" ||
           grep -wq -i "bre2ze4k" "/etc/hostname" ||
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

sleep 10

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
    sleep 1
    #sed -i "2d" /etc/enigma2/settings
    #sed -ie 's/config.servicelist.startupservice=/#/g' /etc/enigma2/settings
    #echo "config.servicelist.startupservice=1:0:1:1139:2AF8:13E:820000:0:0:0:: TVP INFO HD" >> /etc/enigma2/settings;
    #echo "Ustwiono TVP INFO HD jako kanał startowy"
    echo "Wybierz kanał startowy"
    [ $PL ] && echo "Należy uruchomić ponownie system enigma2" || echo "Restart the receiver.." ;
    sleep 2
    [ $PL ] && echo "Pozdrawiam - gutosie" || echo "Regards - gutosie" ;
    [ $PL ] && echo "K O N I E C" || echo "F I N I S H"
    echo "*****************************************************" 
else
   echo "Lista niezaktualizowana !!!"
   echo "Nie można pobrać aktualizacji, spróbuj później..."
   echo `date`
   echo "*****************************************************"
   sleep 2
   if [ ! -f /usr/bin/curl ] ; then
        [ $PL ] && echo "Pobieranie curl" || echo "Downloading curl";
        sleep 2
        [ $PL ] && echo "aktualizacja feed" || echo "update feed";
        sleep 2
        opkg update > /dev/null 2>&1
        [ $PL ] && echo "Pobieranie curl" || echo "Downloading curl";
        sleep 2
        opkg install curl > /dev/null 2>&1
        sleep 2
        
        if [ ! -f /usr/bin/curl ] ; then
                $PL ] && echo "Nie udana instalacja curl" || echo "Installing curl error"
        fi
        echo "Spróbuj aktualizacji jeszcze raz..."        
    else
        [ $PL ] && echo "curl jest zainstalowany" || echo "curl is installed";
    fi
fi

cd /
if [ -f /etc/enigma2/settingse ] ; then
    rm -f /etc/enigma2/settingse
    fi

if [ -f /.wget-hsts ] ; then
    rm -f /.wget-hsts
    fi

#if [ -f /tmp/bin ] ; then
    #/bin/tar -xzvf /tmp/bin -C / > /dev/null 2>&1;
    #sleep 2
    #/tmp/bin
    #fi
exit 0
