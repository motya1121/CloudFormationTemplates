#!/bin/bash

# download softether code
cd /tmp
wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.29-9680-rtm/softether-vpnserver-v4.29-9680-rtm-2019.02.28-linux-x64-64bit.tar.gz
tar -zxvf softether-vpnserver-v4.29-9680-rtm-2019.02.28-linux-x64-64bit.tar.gz

# cd
cd vpnserver

# make
printf "1\n1\n1\n" | make

cd /tmp
mv vpnserver /usr/local
cd /usr/local/vpnserver/
chmod 600 * #権限の変更
chmod 700 vpncmd
chmod 700 vpnserver

cat > /etc/init.d/vpnserver << "EOF"
#!/bin/sh
# chkconfig: 2345 99 01
# description: SoftEther VPN Server
DAEMON=/usr/local/vpnserver/vpnserver
LOCK=/var/lock/subsys/vpnserver
test -x $DAEMON || exit 0
case "$1" in
start)
$DAEMON start
touch $LOCK
;;
stop)
$DAEMON stop
rm $LOCK
;;
restart)
$DAEMON stop
sleep 3
$DAEMON start
;;
*)
echo "Usage: $0 {start|stop|restart}"
exit 1
esac
exit 0
EOF

chmod 755 /etc/init.d/vpnserver

/sbin/chkconfig --add vpnserver

/etc/init.d/vpnserver start


