FROM php:7.0-apache
COPY files /tmp/files/
RUN echo ZGViIGh0dHA6Ly9hcmNoaXZlLmRlYmlhbi5vcmcvZGViaWFuLyBzdHJldGNoIG1haW4gY29udHJpYiBub24tZnJlZQpkZWItc3JjIGh0dHA6Ly9hcmNoaXZlLmRlYmlhbi5vcmcvZGViaWFuLyBzdHJldGNoIG1haW4gY29udHJpYiBub24tZnJlZQpkZWIgaHR0cDovL2FyY2hpdmUuZGViaWFuLm9yZy9kZWJpYW4tc2VjdXJpdHkvIHN0cmV0Y2gvdXBkYXRlcyBtYWluIGNvbnRyaWIgbm9uLWZyZWUKZGViLXNyYyBodHRwOi8vYXJjaGl2ZS5kZWJpYW4ub3JnL2RlYmlhbi1zZWN1cml0eS8gc3RyZXRjaC91cGRhdGVzIG1haW4gY29udHJpYiBub24tZnJlZQ== |base64 -d > /etc/apt/sources.list && \
    apt-get update
RUN chown -R root:root /var/www/html/ && \
    chmod -R 755 /var/www/html && \
    mv /tmp/files/flag.sh / && \
    mv /tmp/files/start.sh / && \
    chmod +x /flag.sh /start.sh && \
    apt-get update && \
    apt-get install libaio1 libnuma1 psmisc libmecab2 redis-server -y && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-common_5.7.29-1debian9_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-community-client_5.7.29-1debian9_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-client_5.7.29-1debian9_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-community-server_5.7.29-1debian9_amd64.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/files/mysql-server_5.7.29-1debian9_amd64.deb && \
    cp -f /tmp/files/redis.conf /etc/redis/redis.conf && \
    rm -rf /tmp/files && \
    docker-php-ext-install mysqli pdo pdo_mysql && \
    pecl install redis && \
    echo "extension=redis.so\n" >> /usr/local/etc/php/conf.d/docker-php-ext-redis.ini && \
    rm -rf /var/lib/apt/lists/*
CMD /start.sh
