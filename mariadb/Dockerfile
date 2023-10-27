FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy config file and script
COPY my.cnf /etc/mysql/conf.d/my.cnf
COPY init-db.sh /usr/local/bin/init-db.sh
RUN chmod +x /usr/local/bin/init-db.sh

# Expose the MariaDB port
EXPOSE 3306

# Initialize database and keep MariaDB running
ENTRYPOINT ["init-db.sh"]
