#!/bin/bash

client=$1;

if [[ -e /etc/debian_version ]]; then
	os="debian"
	group_name="nogroup"
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	os="centos"
	group_name="nobody"
else
	echo "Looks like you aren't running this installer on Debian, Ubuntu or CentOS"
	exit
fi

cd /etc/openvpn/server/easy-rsa/
./easyrsa --batch revoke "$client"
EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl
rm -f pki/reqs/"$client".req
rm -f pki/private/"$client".key
rm -f pki/issued/"$client".crt
rm -f /etc/openvpn/server/crl.pem
cp /etc/openvpn/server/easy-rsa/pki/crl.pem /etc/openvpn/server/crl.pem
# CRL is read with each client connection, when OpenVPN is dropped to nobody
chown nobody:"$group_name" /etc/openvpn/server/crl.pem
echo
echo "Certificate for client $client revoked!"