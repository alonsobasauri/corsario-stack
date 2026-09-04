FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        openssh-server \
        rsyslog \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/sshd /home/webmaster/www \
    # uid/gid 1000:1001 = los mismos que trae el codigo migrado de corsario8
    # (el usuario "paco" alla). Asi Paco puede escribir lo que ya existe sin
    # tener que rechownear el volumen completo.
    && groupadd -g 1001 webmaster \
    && useradd -m -d /home/webmaster -s /usr/sbin/nologin -u 1000 -g webmaster webmaster \
    && chown root:root /home/webmaster \
    && chmod 755 /home/webmaster \
    && chown webmaster:webmaster /home/webmaster/www

COPY sshd_config /etc/ssh/sshd_config
COPY rsyslog.conf /etc/rsyslog.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
