FROM debian:bullseye

# Install MariaDB & some tools
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y mariadb-server mariadb-client curl vim && \
    apt-get clean

ENV MYSQL_DATABASE=db_inception
ENV MYSQL_USER=db_user
ENV MYSQL_PASSWORD=db_password
ENV MYSQL_ROOT_PASSWORD=db_root_password

# Create a folder to store the startup script
RUN mkdir -p /etc/mariadb

# Copy the script from the host to the Docker image
COPY tools/mariadb-script.sh /etc/mariadb/
COPY conf/50-server.cnf /etc/mysql/mariadb/mariadb.conf.d/

# Make sure we can execute the script 
RUN  chmod -R 755 /etc/mariadb

# Only serves as a description
EXPOSE 3306

# Start MariaDB when the container is launched
CMD ["bash", "/etc/mariadb/mariadb-script.sh"]