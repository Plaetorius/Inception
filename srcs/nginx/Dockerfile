# Use debian:bullseye as a base image
FROM debian:bullseye

# Install NGINX & OpenSSL
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create necessary folders on the Docker image
RUN mkdir -p /etc/nginx/ssl && \
	mkdir -p /var/run/nginx

# Generate SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=tgernez.42.fr/UID=tgernez@student.42.fr"

# Copy nginx.conf file to the Docker image
COPY nginx.conf /etc/nginx/nginx.conf


RUN chmod -R 755 /usr/share/nginx/html && \
	chown -R www-data:www-data /usr/share/nginx/html

# Doesn't have any purpose besides describing
EXPOSE 443

# Start NGINX when the container has launched
CMD ["nginx", "-g", "daemon off;"]
