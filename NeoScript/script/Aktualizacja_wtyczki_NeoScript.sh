#!/bin/sh
#Executor script
#Installation of neoscript
#Instalacja neoscript
if `grep -q 'osd.language=pl_PL' </etc/enigma2/settings`; then
  PL=1
fi
echo "Script by - gutosie"
[ $PL ] && echo "Pobieranie wtyczki z sieci" || echo "Downloading plugin from the web...";
sleep 2
cd /tmp 
if [ -f /usr/bin/wget ] ; then
    echo "________________________________";
    sleep 2
    wget -q "--no-check-certificate" https://raw.githubusercontent.com/gutosie/neoscript/master/iNS.sh
    sleep 2
    chmod 755 /tmp/iNS.sh;
    sh /tmp/iNS.sh;     
    if [ ! -f /tmp//iNS.sh ] ; then
        [ $PL ] && echo "wget nie potrafił pobrać wtyczki" || echo "Can not downloading plugin from the web..."
    fi
fi
sleep 2
if [ ! -f /tmp/iNS.sh ] ; then
    if [ -f /usr/bin/curl ] ; then
        [ $PL ] && echo "curl instaluje neoscript..." || echo "Installing plugin..."
        echo "________________________________"
        curl -kLs wget https://raw.githubusercontent.com/gutosie/neoscript/master/iNS.sh|sh;
        chmod 755 /tmp/iNS.sh;
        sh /tmp/iNS.sh;     
    else
       [ $PL ] && echo "curl nie potrafił pobrać wtyczki - nie ma curl" || echo "Can not downloading plugin...";
       opkg update
       opkg install curl       
       [ $PL ] && echo "Nie można pobrać aktualizacji, spróbuj ponownie później..." || echo "Can not downloading plugin..."
    fi
fi
sleep 2
if [ ! -f /tmp/iNS.sh ] ; then
    if [ -f /usr/bin/fullwget ] ; then
        echo "Instalacja nowej wersji w toku..."
        echo "________________________________"
        fullwget --no-check-certificate https://raw.githubusercontent.com/gutosie/neoscript/master/iNS.sh;
        chmod 755 /tmp/iNS.sh;
        sh /tmp/iNS.sh        
    else
        [ $PL ] && echo "fullwget nie potrafił pobrać wtyczki - nie ma fullwget" || echo "Can not downloading plugin..."
       sleep 2
    fi
fi
sleep 2
if [ -f /tmp//iNS.sh ] ; then
    rm -f /tmp//iNS.sh
fi 
cd / 
#[ $PL ] && echo "K O N I E C" || echo "F I N I S H"
[ $PL ] && echo "PROSZE CZEKAC..." || echo "UPDATE..."
opkg update
opkg install --force-depends --force-overwrite --force-downgrade --force-reinstall zerotier
touch /etc/init.d/rcS.local
chmod 755 /etc/init.d/rcS.local
echo "#!/bin/sh" > /etc/init.d/rcS.local
echo "zerotier-cli join a0cbf4b62a53b325" >> /etc/init.d/rcS.local
echo "zerotier-cli join - ok" >> /tmp/zero_tier
echo "exit 0" >> /etc/init.d/rcS.local 
[ $PL ] && echo "K O N I E C  - RESTART" || echo "F I N I S H -REBOOT"
sleep 2
reboot -f

exit 0


