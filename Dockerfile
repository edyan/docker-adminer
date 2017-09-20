FROM    alpine:3.6

# Prepare environment
RUN     addgroup adminer
RUN     adduser -h /app -D -G adminer adminer
RUN     mkdir -p /app
RUN     chown adminer:adminer /app
WORKDIR /app
ENV     ADMINER_VERSION 4.3.1

# Install
RUN     apk update && \

        apk add curl ca-certificates && \

        apk add libcap \
                php5 \
                php5-cli \
                php5-mssql \
                php5-mysqli \
                php5-pgsql \
                php5-sqlite3 && \

         curl https://www.adminer.org/static/download/${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -s -S -o index.php && \

         apk del curl ca-certificates

RUN      setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/php5
EXPOSE   80

USER     adminer
CMD      ["/usr/bin/php5", "-S", "0.0.0.0:80", "-t", "/app"]
