#!/bin/shell 

#
#	Script para instalação automatizada do Yara v4.1.3
#	Autor: Ícaro César
#

header ()
{
	echo ''
	echo '  ---- Yara v4.1.3 Full Installation ----'
	sleep 1
	echo ''

}


update_upgrade ()
{
	echo ''
	echo '[+] Updating the Database'
	echo ''
	sleep 1
	apt-get update
	echo''
	echo'[+] Database Update is Completed!'
	echo ''
	echo '[+] Upgrade Packages (with necessary)!'
	echo ''
	sleep 1

	apt-get upgrade -y

	sleep 1
	echo ''
	echo '[+] Packages Upgrade is completed!'
	echo''
}

yara_reqs ()
{
	echo''
	sleep 1
	echo '  ---- Requirements Installation ----'
	echo''
	sleep 1
	echo'[+] Library Install: automake'
	echo''
	apt-get install automake

	echo''
	sleep 1
	echo '[+] Library Install: libtool'
	apt-get install libtool

	echo''
	sleep 1
	echo'[+] Library Install: make'
	apt-get install make

	echo''
	sleep 1
	echo '[+] Library Install: gcc'
	apt-get install gcc

	echo''
	sleep 1
	echo'[+] Library Install: pkg-config'
	apt-get install pkg-config

}

yara_download ()
{

	echo''
	echo''
	echo'   ---- Download the Yara Repository ----'
	echo''

	cd ~
	curl --output yara.zip -L 'https://github.com/VirusTotal/yara/archive/refs/tags/v4.1.3.zip'
	unzip yara.zip
	cd yara-4.1.3/

}

yara_conf ()
{

	echo ''
	echo '  ---- Executing the bootstrap Script ----'
	echo''
	./bootstrap.sh
	echo''
	echo'[+] bootstrap script executed!'
	sleep 1
	echo ''

	echo '  ---- Configuring the Yara ----'
	./configure
	make
	sudo make install
	make check

	echo''
	echo'[+] Yara Configuration Completed!'
	sleep 1
	echo''

}

yargen ()
{

echo'   ---- Download the YarGen Repository ----'
echo ''

cd ~
curl --output yargen.zip -L 'https://github.com/Neo23x0/yarGen/archive/refs/heads/master.zip'
echo''
echo'[+] Installing Dependencies'
echo''
unzip yargen.zip
cd yarGen-master/
apt install python3-pip && pip --version
pip install pefile cd && pip install scandir lxml naiveBayesClassifier

echo''
echo'[+] Update the YarGen\'s Database'
sleep 1
echo''
echo'Tip: Go make a good coffe.. this will take a time :-)'
echo''
python3 yarGen.py --update
sleep 1
echo''

}

header

if [[ $EUID -ne 0 ]]; 
then
	echo "This script must be run as root" 1>&2
	exit 1

else
	update_upgrade
	yara_reqs
	yara_download
	yara_conf
	yargen


fi

echo '	---- End of the Script ----'
echo''
