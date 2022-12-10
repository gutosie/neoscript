#!/bin/sh
#
#skrypt instaluje neoscript
#
BOXHOSTNAME=$( cat /etc/hostname)
if `grep -q 'osd.language=pl_PL' </etc/enigma2/settings`; then
  PL=1
fi
if [ -f /etc/apt/apt.conf ] ; then
    STATUS='/var/lib/dpkg/status'
    OS='DreamOS'
elif [ -f /etc/opkg/opkg.conf ] ; then
   STATUS='/var/lib/opkg/status'
   OS='Opensource'
fi
if [ ! -e /usr/lib/enigma2/python/Plugins/Extensions ]; then
    [ -e /tmp/neoscript.zip ] && rm -f /tmp/neoscript.zip
    [ -e /tmp/neoscript-main ] && rm -rf /tmp/neoscript-main
    echo ""
    echo "N E O S C R I P T"
    echo ""
    [ $PL ] && echo "Pobieranie archiwum..." || echo "Downloading archive file..."
    echo "*****************************************************"
    URL='https://github.com/gutosie/neoscript/archive/refs/heads/main.zip'
    curl -kLs $URL  -o /tmp/neoscript.zip
    Cel="/usr/lib/enigma2/python/Plugins/Extensions"

    cd /tmp/
    #pobieranie
    if [ ! -e /tmp/neoscript.zip ]; then 
       wget --no-check-certificate $URL  
       mv -f /tmp/main.zip /tmp/neoboot.zip  
    fi
    if [ ! -e /tmp/neoscript.zip ]; then 
       fullwget --no-check-certificate $URL  
       mv -f /tmp/main.zip /tmp/neoscript.zip  
    fi
    unzip -qn ./neoscript.zip
    rm -f /tmp/neoscript.zip
    [ -e /tmp/main.zip ] && rm -rf /tmp/main.zip

    #kopiowanie
    [ $PL ] && echo "Instalowanie..." || echo "Instaling..."
    echo "*****************************************************"
    [ -e $Cel/NeoScript ] && rm -rf $Cel/NeoScript/* || mkdir -p $Cel/NeoScript

    mv -f /tmp/neoscript-main/NeoScript/* $Cel/NeoScript
    [ -e /tmp/neoscript-main ] && rm -rf /tmp/neoscript-main

    if [ $PL ] ; then
      echo ""
      echo "#####################################################"
      echo "#            NEOSCRIPT ZAINSTALOWANY                #"
      echo "#####################################################"
      echo ""
    else
      echo ""
      echo "#####################################################"
      echo "#   >>> NEOSCRIPT INSTALLED SUCCESSFULLY <<<        #"
      echo "#####################################################"
      echo ""
    fi
    echo "*******************************************************"
    echo "                 N E O S C R I P T                     "    
    echo "          ----- Restart Enigma2 GUI -----              "
    echo "*******************************************************"
    sleep 2
    if [ $OS = 'DreamOS' ]; then 
        systemctl restart enigma2
    else
        killall -9 enigma2
    fi
else
    if [ $PL ] ; then
      echo ""
      echo "#####################################################"
      echo ">>>>     Błąd!    To nie jest image flash.       <<<<"
      echo ">>>>     Instaluj neoscript tylko z Flash.       <<<<"
      echo "#####################################################"
      echo ""
    else
      echo ""
      echo "#####################################################"
      echo ">>>>     Error!   Go back to image flash.        <<<<"
      echo ">>>>     To install neoscript go back to Flash.  <<<<"
      echo "#####################################################"
      echo ""
    fi
fi
exit 0 

