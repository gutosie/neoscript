#!/bin/bash

##setup command=wget -q "--no-check-certificate" https://raw.githubusercontent.com/Belfagor2005/vavoo/main/installer.sh -O - | /bin/sh

CHECKHOST=`cat /etc/hostname`

CHECK='/tmp/check'
uname -m > $CHECK

sleep 1;

if grep -qs -i 'sh4' cat $CHECK ; then
	        echo "[ Your device is sh4 ] Your device is not supported"

elif grep -qs -i 'mips' cat $CHECK ||
             grep -qs -i 'osnino' cat $CHECKHOST ||
             grep -qs -i 'osninoplus' cat $CHECKHOST  ; then
             echo " Your device is MIPS" $CHECKHOST
             sleep 1;
             wget -q "--no-check-certificate" https://raw.githubusercontent.com/Belfagor2005/vavoo/main/installer.sh -O - | /bin/sh
             
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
           echo " Your device is armv7l" $CHECKHOST
           sleep 1;
           wget -q "--no-check-certificate" https://raw.githubusercontent.com/Belfagor2005/vavoo/main/installer.sh -O - | /bin/sh
	        
else
            echo "Your device is not supported"
fi

exit 0
