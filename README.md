# Zabbix-Agent for libzbxpgsql

Since libzbxpgsql is capable of monitoring one database per zabbix-agent,
this container can be used for run separate zabbix-agent for each PostgreSQL
instance that we want to monitor.

## Docker Image
Docker Image is already build and you can find it here: https://hub.docker.com/r/akomic/zbx-pgsql-agent/

If you however need to make any changes here is how to build it again

- Edit .release file
- Run
```
make all
```

## Running container

- Edit docker-compose.yml

```
docker-compose up -d
```

Agents will be accessible on localhost and in this case on ports: 20050, 20051
