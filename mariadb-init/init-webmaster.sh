#!/bin/sh
# Crea al usuario webmaster con los mismos privilegios que root (decision de Alonso,
# 2026-09-03). Se toma la password de la variable de entorno WEBMASTER_DB_PASSWORD del
# propio contenedor -- NUNCA en claro aqui, para que este fichero pueda vivir en un
# repositorio publico. Ver docker-compose.yml (environment de mariadb) y el arranque
# de Portainer para donde vive de verdad el valor.
set -e

if [ -z "${WEBMASTER_DB_PASSWORD:-}" ]; then
    echo "FALTA WEBMASTER_DB_PASSWORD" >&2
    exit 1
fi

mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" <<-EOSQL
    CREATE USER IF NOT EXISTS 'webmaster'@'%' IDENTIFIED BY '${WEBMASTER_DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO 'webmaster'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOSQL
