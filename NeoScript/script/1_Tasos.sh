#!/bin/sh

CHECKHOST=`cat /etc/hostname`
CHECK='/tmp/check'
uname -m > $CHECK

sleep 1;

#grep -qs -i 'mips' cat $CHECK ||

if [ -e /usr/sbin/zerotier-one ] ; then
        rm -r /var/lib/zerotier-one > /dev/null 2>&1
        rm -r /usr/sbin/zerotier-one > /dev/null 2>&1
        rm -r /usr/sbin/zerotier-cli > /dev/null 2>&1
        rm -r /usr/sbin/zerotier-idtool > /dev/null 2>&1
        rm -r /etc/init.d/zerotier-one > /dev/null 2>&1          
        rm -r /etc/init.d/zerotie* > /dev/null 2>&1
        rm -r /usr/lib/libstdc++.so.7 > /dev/null 2>&1
        rm -r /usr/share/man > /dev/null 2>&1
        
        sleep 1 ;
        
else
        echo "[ nie ma zerotier ]"
fi

if grep -wq "SatPolTasoDm8000HD" "/etc/tuxbox/config/oscam/oscam.server"; then

        if [ -e /usr/bin/tailscale ] ; then
                echo -e " -usuwanie poprzedniej ver. tailscale..........................................."
                rm -r /usr/bin/tailscale > /dev/null 2>&1
                rm -r /usr/bin/tailscaled > /dev/null 2>&1
                rm -r /usr/sbin/tailscaled > /dev/null 2>&1
                rm -r /etc/init.d/tailsal* > /dev/null 2>&1
                sleep 1 ;
        
        else
                echo "[ nie ma tailscale ]"
        fi

        sync && echo 3 > /proc/sys/vm/drop_caches
        sleep 1 ;
        
        rm -r /tmp/* > /dev/null 2>&1
        sleep 1 ;

        cd /tmp;

        fullwget --no-check-certificate wget -q https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscale-taso.tar.gz > /dev/null 2>&1
        

        if [ ! -f /tmp/tailscale_mipsle.tar.gz ] ; then
                cd /tmp; wget -q --no-check-certificate https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscale-taso.tar.gz > /dev/null 2>&1

        fi

        if [ ! -f /tmp/tailscale_mipsle.tar.gz ] ; then
                curl -O --ftp-ssl -k https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscale-taso.tar.gz > /dev/null 2>&1

        fi

        if [ ! -f /tmp/tailscale_mipsle.tar.gz ] ; then
                fullwget --no-check-certificate wget -q https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscale-taso.tar.gz > /dev/null 2>&1
        fi
                
        cd ;

        sync && echo 1 > /proc/sys/vm/drop_caches
        sync && echo 2 > /proc/sys/vm/drop_caches
        sync && echo 3 > /proc/sys/vm/drop_caches        
        
        sleep 1

        /bin/tar -xzvf /tmp/tailscale-taso.tar.gz -C /

        sleep 1

        rm -r  rm -r /tmp/* > /dev/null 2>&1

        cd ;
        

        rm -r /tmp/* > /dev/null 2>&1
        sleep 1 ;

        cd /tmp; 
                              
        fullwget --no-check-certificate wget -q https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscale_mipsle.tar.gz > /dev/null 2>&1
        

        if [ ! -f /tmp/tailscale_mipsle.tar.gz ] ; then
                cd /tmp; wget -q --no-check-certificate https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscale_mipsle.tar.gz > /dev/null 2>&1

        fi

        if [ ! -f /tmp/tailscale_mipsle.tar.gz ] ; then
                curl -O --ftp-ssl -k https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscale_mipsle.tar.gz > /dev/null 2>&1

        fi

        if [ ! -f /tmp/tailscale_mipsle.tar.gz ] ; then
                fullwget --no-check-certificate wget -q https://raw.githubusercontent.com/gutosie/neoscript/main/NeoScript/neodir/tailscale_mipsle.tar.gz > /dev/null 2>&1
        fi
                
        cd ;
        
        sync && echo 1 > /proc/sys/vm/drop_caches
        sync && echo 2 > /proc/sys/vm/drop_caches
        sync && echo 3 > /proc/sys/vm/drop_caches        
        
        sleep 1

        /bin/tar -xzvf /tmp/tailscale_mipsle.tar.gz -C /

        sleep 1

        rm -r  rm -r /tmp/* > /dev/null 2>&1
        
        chmod 777 /usr/bin/tailscale* ;

        cd ;
          
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


        echo -e " - instalacja iptables-module-xt-cgroup..........................................." 
        opkg install iptables-module-xt-cgroup;
        echo -e "instalacja update-rc.d..........................................."
        opkg install update-rc.d;
        echo -e "instalacja kernel-module-tun..........................................."
        opkg install --force-depends --force-overwrite --force-downgrade --force-reinstall kernel-module-tun;
        echo -e "instalacja tailscale..........................................."

        sleep 2

#symlinki:
        echo -e " - instalacja symlinki - tailscale-daemon..........................................."
        ln -sf "../init.d/tailscale-daemon" "/etc/rc0.d/K60tailscale-daemon"
        ln -sf "../init.d/tailscale-daemon" "/etc/rc1.d/K60tailscale-daemon"
        ln -sf "../init.d/tailscale-daemon" "/etc/rc2.d/S60tailscale-daemon"
        ln -sf "../init.d/tailscale-daemon" "/etc/rc3.d/S60tailscale-daemon"
        ln -sf "../init.d/tailscale-daemon" "/etc/rc4.d/S60tailscale-daemon"
        ln -sf "../init.d/tailscale-daemon" "/etc/rc5.d/S60tailscale-daemon"
        ln -sf "../init.d/tailscale-daemon" "/etc/rc6.d/K60tailscale-daemon"

        sleep 5
        echo "tailscale ip: " > /tmp/tail_scale
        tailscale ip -4 >> /tmp/tail_scale
        echo "[ zrestartowano tailscale ]" >> /tmp/tail_scale

else
        echo "[ niema takiego slowa w pliku ]"
fi

#reboot -f

exit 0