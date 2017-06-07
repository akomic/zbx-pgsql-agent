FROM debian:jessie

LABEL maintainer "Alen Komic <akomic@gmail.com>"

ENV LIBZBXPGSQL_URL=http://cdn.cavaliercoder.com/libzbxpgsql/apt/zabbix32/debian/jessie/amd64/libzbxpgsql_1.1.0-1%2Bjessie_amd64.deb AGENT_URL=http://repo.zabbix.com/zabbix/3.2/debian/pool/main/z/zabbix/zabbix-agent_3.2.6-1+jessie_amd64.deb

RUN  apt-get update -qq && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y wget libpq5 locales libcurl3 libconfig9 && \
	locale-gen en_US.UTF-8 && \
	wget -q ${AGENT_URL} -O zabbix-agent.deb && dpkg -i zabbix-agent.deb && \
	wget -q ${LIBZBXPGSQL_URL} -O libzbxpgsql.deb && dpkg -i libzbxpgsql.deb && \
	mkdir /var/lib/zabbix /var/run/zabbix && chmod 0755 /var/lib/zabbix && \
	echo "PGPASSFILE=/var/lib/zabbix/.pgpass" > /etc/default/zabbix-agent && \
	echo "LoadModule=libzbxpgsql.so" > /etc/zabbix/zabbix_agentd.d/libzbxpgsql.conf && chown zabbix. /etc/zabbix/zabbix_agentd.d/libzbxpgsql.conf && \
	chown -R zabbix. /etc/zabbix /var/run/zabbix /var/lib/zabbix && \
        apt-get -y purge build-essential && \
        apt-get -y autoremove && \
        apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD config-and-run.sh /

STOPSIGNAL SIGKILL

USER zabbix

ENTRYPOINT ["/config-and-run.sh"]
