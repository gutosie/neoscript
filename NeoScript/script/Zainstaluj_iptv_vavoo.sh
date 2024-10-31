#!/bin/bash

##setup_command=wget -q "--no-check-certificate" https://raw.githubusercontent.com/Belfagor2005/vavoo/main/installer.sh -O - | /bin/sh

CHECKHOST=`cat /etc/hostname`

CHECK='/tmp/check'
uname -m > $CHECK

Linkvavoo='https://raw.githubusercontent.com/Belfagor2005/vavoo/main/installer.sh'
sleep 1;

if grep -qs -i 'sh4' cat $CHECK ; then
	        echo "[ Twoje STB to: sh4 ] Your device is not supported"

elif grep -qs -i 'mips' cat $CHECK ||
             grep -qs -i 'osnino' cat $CHECKHOST ||
             grep -qs -i 'osninoplus' cat $CHECKHOST  ; then
             
             echo " Twoje STB to: MIPS" $CHECKHOST

           echo " Twoje STB to: armv7l" $CHECKHOST
           echo " Pobieranie pliku vavoo..."
           cd /tmp; curl -O --ftp-ssl -k $Linkvavoo > /dev/null 2>&1
           sleep 1;
           chmod 755 /tmp/installer.sh
           echo " Instalacja wtyczki vavoo..."
           sleep 1; 
           /tmp/installer.sh > /dev/null 2>&1
	   echo " Wtyczka vavoo zainstalowana"
           rm /tmp/installer.sh
             
elif grep -qs -i 'armv7l' cat $CHECK ||
           grep -qs -i 'vuduo4k' cat $CHECKHOST ||
           grep -qs -i 'zgemmah9twin' cat $CHECKHOST ||         
           grep -qs -i 'h9combo' cat $CHECKHOST ||
           grep -qs -i 'h8' cat $CHECKHOST ||
           grep -qs -i 'ustym4kpro' cat $CHECKHOST ||
           grep -qs -i 'protek4kx1' cat $CHECKHOST ||        
           grep -qs -i 'osmio4k' cat $CHECKHOST ||
           grep -qs -i 'lunix4k' cat $CHECKHOST ||         
           grep -qs -i 'osmio4k' cat $CHECKHOST ||
           grep -qs -i 'hitube4k' cat $CHECKHOST ||        
           grep -qs -i 'axashistwin' cat $CHECKHOST ||
           grep -qs -i 'bre2ze4k' cat $CHECKHOST  ; then
           
           echo " Twoje STB to: armv7l" $CHECKHOST
           echo " Pobieranie pliku vavoo..."
           cd /tmp; curl -O --ftp-ssl -k $Linkvavoo > /dev/null 2>&1
           sleep 1;
           chmod 755 /tmp/installer.sh
           echo " Instalacja wtyczki vavoo..."
           sleep 1; 
           /tmp/installer.sh > /dev/null 2>&1
	   echo " Wtyczka vavoo zainstalowana"
           rm /tmp/installer.sh    

else
            echo "Twoje STB nie jest wspierane !"
fi

exit 0
