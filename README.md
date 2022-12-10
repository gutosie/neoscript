# neoscript
#Executor script

#Installation of neoscript. Run the following command in the terminal of tuner

#Instalacja neoscript. Uruchom poniższą komendę w terminalu tunera

#
opkg update

opkg install curl

curl -kLs wget https://raw.githubusercontent.com/gutosie/neoscript/master/iNS.sh|sh

###########################################################
-jeśli w/w polecenie nie zadział próbujemy polecenia:

-if the command doesn't work, try the command:

cd /tmp; wget -q https://raw.githubusercontent.com/gutosie/neoscript/master/iNS.sh ; 
chmod 755 ./iNB.sh;
sh ./iNB.sh; 
rm ./iNB.sh; cd

############################################################
-jeśli w/w polecenie nie zadział próbujemy następne polecenia:

-if the command doesn't work, try the command:

cd /tmp; fullwget --no-check-certificate https://raw.githubusercontent.com/gutosie/neoscript/master/iNS.sh ; 
chmod 755 ./iNB.sh; 
sh ./iNB.sh; 
rm ./iNB.sh; cd
