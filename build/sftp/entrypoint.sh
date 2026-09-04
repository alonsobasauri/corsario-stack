#!/bin/bash
set -euo pipefail

if [ -z "${WEBMASTER_PASSWORD:-}" ]; then
    echo "FALTA WEBMASTER_PASSWORD" >&2
    exit 1
fi

echo "webmaster:${WEBMASTER_PASSWORD}" | chpasswd

mkdir -p /var/run/sshd
ssh-keygen -A

touch /var/log/auth.log /var/log/syslog
chmod 640 /var/log/auth.log /var/log/syslog

mkdir -p /home/webmaster/www
chown webmaster:webmaster /home/webmaster/www
chown root:root /home/webmaster
chmod 755 /home/webmaster

rsyslogd
exec /usr/sbin/sshd -D
