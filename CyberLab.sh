#!/bin/bash

#User Input
read -p "Enter employee name: " empName
read -p "Enter employee id: " empId


filename=$name-$id

# echo "Please select a service"
# echo " 1) Lab VPN"
# echo " 2) Team Viewer"
# echo " 3) Nessus"
# echo " 4) Check existing connections"
# read -p "Select an option: " key_option
# until [[ "$key_option" =~ ^[1-4]$ ]]; do
			# echo "$option: invalid selection."
			# read -p "Select an option: " key_option
		# done

# case "$key_option" in
	# 1)
	# ;;
	# 2)
	# ;;
	# 3)
	# ;;
	# 4)
	# ;;
# esac


fetchCronData () {
If [crontab -l | grep -q '$filename'] then
echo "Following enteries for the users already exist"
crontab -l 2> /dev/null | grep "$filename"
else
echo "No pre-existing entries for the user"
fi
}

createVPNprofile () {

read -p "Enter VPN expiry date(dd mm): " dd mm

dd1 = --$dd;

./bin/createuser.exp $filename

alert1='VPN access expires tomorrow for'
alert2='VPN access revoked!'

echo "Profile Successfully created.  Adding crontab..."

(crontab -l 2> /dev/null; echo "00 11 $dd1 $mm * /usr/local/bin/telegram-send --config /etc/telegram-send/group.conf '$alert1 $filename'; crontab -l | grep -v '$alert1 $filename' | crontab") | crontab -

(crontab -l 2> /dev/null; echo "00 11 $dd1 $mm * bash deluser.sh $filename | /usr/local/bin/telegram-send --config /etc/telegram-send/group.conf '$alert1 $filename'; crontab -l | grep -v '$alert1 $filename' | crontab") | crontab -

}




#Command
(crontab -l 2> /dev/null; echo "00 00 $dd $mm * telegram-send --config name.config '$id: $alert1'; crontab -l | grep -v '$id: $alert1' | crontab") | crontab - 
(crontab -l 2> /dev/null; echo "59 23 $dd $mm * telegram-send --config name.config '$id: $alert2'; crontab -l | grep -v '$id: $alert2' | crontab") | crontab - 
(crontab -l 2> /dev/null; echo "9 37 05 08 * ls > touch.txt; crontab -l | grep -v 'touch' | crontab") | crontab -


