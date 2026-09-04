# corsario-stack

Pila docker compose (Traefik + Apache/PHP + MariaDB + phpMyAdmin + Gotenberg + SFTP + fail2ban
+ Ofelia) del Linode nuevo de corsario (cliente exclusivo de Paco Rangel), desplegada por
Portainer en `173.255.192.167`.

Este repositorio es **público a propósito** (decisión de Alonso, 2026-09-04) para que Portainer
lo pueda traer sin ninguna credencial. **No contiene ningún secreto.**

## Este repositorio SOLO no basta para levantar el servidor

Hacen falta 3 variables de entorno que **no viven aquí**, sino como "Environment variables" del
stack en Portainer (persisten en el servidor, nunca en git). Sus valores están en el baúl del
hub (`credentials.md` → "SERVIDOR NUEVO MicroOS"):

- `MARIADB_ROOT_PASSWORD`
- `WEBMASTER_DB_PASSWORD` (usuario `webmaster` de MariaDB / login de phpMyAdmin — mismos
  privilegios que root)
- `SFTP_WEBMASTER_PASSWORD` (usuario `webmaster` del contenedor SFTP, puerto 22)

Sin esas 3, `mariadb` y `sftp` no arrancan bien (o arrancan con credenciales vacías/rotas).

## Estructura

- `docker-compose.yml` — la pila completa.
- `mariadb-init/init-webmaster.sh` — crea al usuario `webmaster` de MariaDB al primer arranque
  (sólo corre si el volumen de datos está vacío).
- `fail2ban/` — jail y acción para banear intentos fallidos de SSH al SFTP.
- `build/web/`, `build/sftp/` — Dockerfile + contexto de las 2 imágenes propias
  (`corsario-web`, `corsario-sftp`).

El código real del sitio de Paco **no vive aquí** — vive en el volumen `web_html`, que él edita
por SFTP (puerto 22).
