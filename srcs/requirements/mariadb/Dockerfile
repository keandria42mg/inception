FROM debian:bookworm-slim

RUN	apt-get update -y && \
  apt-get install -y \
  mariadb-server \
  mariadb-client

RUN	mkdir -p /run/mysqld /var/lib/mysql /var/log/mysql/ && \
  chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mysql/ && \
  chmod 755 /var/log/mysql/

RUN	mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal --skip-test-db

COPY ./conf/50-server.cnf /etc/mysql/50-server.cnf
CMD chmod 644 /etc/mysql/50-server.cnf

COPY ./tools/entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Command launched at the end of the setup
CMD ["/usr/bin/mysqld_safe", "--defaults-file=/etc/mysql/50-server.cnf", "--datadir=/var/lib/mysql"]
