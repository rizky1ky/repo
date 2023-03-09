clear
echo -e "\t\t\t\t\e[1;36;41m TES AJA YA \e[0m"
sleep 1s

clear

#repository
echo "deb http://kartolo.sby.datautama.net.id/debian/ buster main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian/ buster-updates main contrib non-free
deb http://kartolo.sby.datautama.net.id/debian-security/ buster/updates main contrib non-free" >> /etc/apt/sources.list

apt update -y

#install resource
apt install apache2 -y
apt install php7.3 -y
apt install php7.3-mysql -y
apt install mariadb-server -y

#wordpress
cd /var/www/html
wget wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
rm latest.tar.gz
cd wordpress
cp wp-config-sample.php wp-config.php

clear
#database
DBName=
            while [[ $DBName = "" ]]; do
              echo -e "\t\t\t\tMASUKIN NAMA DATABASE: \c"
              read DBName
            done

DBUser=
            while [[ $DBUser = "" ]]; do
              echo -e "\t\t\t\tMASUKIN USER: \c"
              read DBUser
            done

DBPass=
            while [[ $DBPass = "" ]]; do
              echo -e "\t\t\t\tMASUKIN PASSWORD : \c"
              read DBPass
            done

clear
sleep 1s

#set database
                sed -i "s/database_name_here/$DBName/" /var/www/html/wordpress/wp-config.php

                sed -i "s/username_here/$DBUser/" /var/www/html/wordpress/wp-config.php

                sed -i "s/password_here/$DBPass/" /var/www/html/wordpress/wp-config.php
                
#mysql
mysql -u root -p -e "CREATE DATABASE $DBName"
mysql -u root -p -e "CREATE USER '$DBUser'@'localhost' identified by '$DBPass'; "
mysql -u root -p -e "GRANT ALL PRIVILEGES ON *.* to '$DBUser'@'localhost'; "
mysql -u root -p -e "FLUSH PRIVILEGES; "

clear

#finish
echo -e "\t\t\tTAMATLAH SUDAHH \c"
