FROM alpine:3.6

RUN mkdir -p /app
WORKDIR /app
ENV ADMINER_VERSION 4.3.1

RUN apk update && \

    apk add curl ca-certificates && \

    apk add php5 \
            php5-cli \
            php5-mssql \
            php5-mysqli \
            php5-pgsql \
            php5-sqlite3 && \

    curl https://www.adminer.org/static/download/${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -s -S -o index.php && \

    apk del curl ca-certificates

EXPOSE 80

CMD ["/usr/bin/php5", "-S", "0.0.0.0:80", "-t", "/app"]
