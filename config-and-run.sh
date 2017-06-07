#!/usr/bin/env bash

[ -z $PG_LINE ] && { echo "PG_LINE env not defined! (format - hostname:port:database:username:password)"; exit 1; }
[ -z $SERVER_IP ] && { echo "SERVER_IP env not defined!"; exit 1; }
[ -z $HOST_NAME ] && { echo "HOST_NAME env not defined!"; exit 1; }
[ -z $LISTEN_PORT ] && { echo "LISTEN_PORT env not defined!"; exit 1; }

sed -i 's@Server=.*@Server='"$SERVER_IP"'@g' /etc/zabbix/zabbix_agentd.conf
sed -i 's@Hostname=.*@Hostname='"$HOST_NAME"'@g' /etc/zabbix/zabbix_agentd.conf
sed -i 's@# LogType=file@LogType=console@g' /etc/zabbix/zabbix_agentd.conf
sed -i 's@# ListenPort=10050@ListenPort='"$LISTEN_PORT"'@g' /etc/zabbix/zabbix_agentd.conf

echo "${PG_LINE}" > /var/lib/zabbix/.pgpass
chown zabbix. /var/lib/zabbix/.pgpass
chmod 0600 /var/lib/zabbix/.pgpass

/usr/sbin/zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf -f
