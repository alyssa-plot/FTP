#user must be root

groupadd ftpUsers

while IFS=, read -r vID vPrenom vNom vMDP vRole ; do

        vUsername=$vNom$vPrenom
        adduser -p $(openssl passwd -1 $vMDP) $vUsername
	usermod -aG ftpUsers $vUsername

        if [ $vRole = 'Admin' ]; then
        usermod -aG sudo $vUsername
        fi

done < Shell_Userlist.csv

cat proftpd.conf > /etc/proftpd/proftp.conf
