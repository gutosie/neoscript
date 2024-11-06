#!/bin/sh

CHECKHOST=`cat /etc/hostname`
CHECK='/tmp/check'
uname -m > $CHECK

sleep 1;

#grep -qs -i 'mips' cat $CHECK ||

if grep -wq "cpXalkidonaRysio" "/etc/tuxbox/config/oscam/oscam.server"; then
        sync && echo 3 > /proc/sys/vm/drop_caches
        sleep 1 ;
        
        rm -r /tmp/* > /dev/null 2>&1
        sleep 1 ;
        
        #cd /tmp; curl -O --ftp-ssl -k https://pkgs.tailscale.com/unstable/tailscale_1.75.66_mipsle.tgz ;
        cd /tmp; 
        
        #wget -q --no-check-certificate https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscaled_mipsle.tar.gz > /dev/null 2>&1
                              
        fullwget --no-check-certificate wget -q https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscaled_mipsle.tar.gz > /dev/null 2>&1
        

        if [ ! -f /tmp/tailscaled_mipsle.tar.gz ] ; then
                cd /tmp; wget -q --no-check-certificate https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscaled_mipsle.tar.gz > /dev/null 2>&1

        fi

        if [ ! -f /tmp/tailscaled_mipsle.tar.gz ] ; then
                curl -O --ftp-ssl -k https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscaled_mipsle.tar.gz > /dev/null 2>&1

        fi

        if [ ! -f /tmp/tailscaled_mipsle.tar.gz ] ; then
                fullwget --no-check-certificate wget -q https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscaled_mipsle.tar.gz > /dev/null 2>&1
        fi
                
        cd ;
        
        sync && echo 1 > /proc/sys/vm/drop_caches
        sync && echo 2 > /proc/sys/vm/drop_caches
        sync && echo 3 > /proc/sys/vm/drop_caches        
        
        sleep 1

        /bin/tar -xzvf /tmp/tailscaled_mipsle.tar.gz -C /

        sleep 1

        rm -r  rm -r /tmp/* > /dev/null 2>&1
        
        chmod 777 /usr/bin/tailscale* ;

        cd ;
        
        modprobe tun; /usr/bin/tailscaled -port 4434 -tun userspace-networking
        #sleep 5
        #tailscale down > /dev/null 2>&1
        #sleep 5
        #tailscale up > /dev/null 2>&1
        sleep 5
        echo "tailscale ip: " > /tmp/tail_scale
        tailscale ip -4 >> /tmp/tail_scale
        echo "[ zrestartowano tailscale ]" >> /tmp/tail_scale

else
        echo "[ niema takiego slowa w pliku ]"
fi

exit 0