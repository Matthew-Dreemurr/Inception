FROM debian:bullseye

RUN apt-get update && apt-get install -y \
  mariadb-server \
  && rm -rf /var/lib/apt/lists/*

# COPY tools/50-server.cnf etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/db.sh /
RUN chmod +x /db.sh

ENTRYPOINT [ "/db.sh" ]