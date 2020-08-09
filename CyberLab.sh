#!/bin/bash

#User Input
read -p "Enter employee name: " empName
read -p "Enter employee id: " empId


filename=$name-$id


fetchCronData () {
file1=$1;
If [crontab -l | grep -q '$file1'] then
sleep(2)
echo "Following enteries for the users already exist"
crontab -l 2> /dev/null | grep "$file1"
else
sleep(2)
echo "No pre-existing entries for the user"
fi
}

createVPNprofile () {
file2=$1;
read -p "Enter VPN expiry date(dd mm): " dd mm
dd1=--$dd;
./bin/createuser.exp $file2
alert1='VPN access expires tomorrow for'
alert2='VPN access revoked!'
sleep(2)
echo "Profile Successfully created for $file1.  Adding crontab..."
(crontab -l 2> /dev/null; echo "00 11 $dd1 $mm * /usr/local/bin/telegram-send --config /etc/telegram-send/group.conf '$alert1 $file2'; crontab -l | grep -v '$alert1 $file2' | crontab") | crontab -
(crontab -l 2> /dev/null; echo "00 11 $dd $mm * bash deluser.sh $filename | /usr/local/bin/telegram-send --config /etc/telegram-send/group.conf '$alert2 $file2'; crontab -l | grep -v '$alert2 $file2' | crontab") | crontab -
sleep(2)
echo "cron jobs installed" 
}

installCronTeam () {
file3=$1;
read -p "Enter Team Viewer expiry date(dd mm): " dd mm
dd1=--$dd;
alert1='Team Viewer access expires tomorrow for'
alert2='Team Viewer access revoked!'
sleep(2)
echo "Adding crontab..."
(crontab -l 2> /dev/null; echo "00 11 $dd1 $mm * /usr/local/bin/telegram-send --config /etc/telegram-send/group.conf '$alert1 $file3'; crontab -l | grep -v '$alert1 $file3' | crontab") | crontab -
(crontab -l 2> /dev/null; echo "00 11 $dd $mm * /usr/local/bin/telegram-send --config /etc/telegram-send/group.conf '$alert2 $file3'; crontab -l | grep -v '$alert2 $file3' | crontab") | crontab -
sleep(2)
echo "cron jobs installed"
}

installCronNessus () {
file4=$1;
read -p "Enter Nessus expiry date(dd mm): " dd mm
dd1=--$dd;
alert1='Nessus access expires tomorrow for'
alert2='Nessus access revoked!'
sleep(2)
echo "Adding crontab..."
(crontab -l 2> /dev/null; echo "00 11 $dd1 $mm * /usr/local/bin/telegram-send --config /etc/telegram-send/group.conf '$alert1 $file4'; crontab -l | grep -v '$alert1 $file4' | crontab") | crontab -
(crontab -l 2> /dev/null; echo "00 11 $dd $mm * /usr/local/bin/telegram-send --config /etc/telegram-send/group.conf '$alert2 $file4'; crontab -l | grep -v '$alert2 $file4' | crontab") | crontab -
sleep(2)
echo "cron jobs installed"
}

echo "Please select a service"
echo " 1) Lab VPN"
echo " 2) Team Viewer"
echo " 3) Nessus"
read -p "Select an option: " key_option
until [[ "$key_option" =~ ^[1-3]$ ]]; do
			echo "$option: invalid selection."
			read -p "Select an option: " key_option
		done

case "$key_option" in
	1)
	echo "Fetching Cron data"
	sleep(2)
	fetchCronData $filename
	createVPNprofile $filename
	fetchCronData $filename
	exit
	;;
	2)
	echo "Fetching Cron data"
	sleep(2)
	fetchCronData $filename
	installCronTeam $filename
	fetchCronData $filename
	exit
	;;
	3)
	echo "Fetching Cron data"
	sleep(2)
	fetchCronData $filename
	installCronNessus $filename
	fetchCronData $filename
	exit
	;;
esac
