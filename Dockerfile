FROM    alpine:3.8

# Prepare environment
RUN     addgroup adminer
RUN     adduser -h /app -D -G adminer adminer
RUN     mkdir -p /app
RUN     chown adminer:adminer /app
ENV     ADMINER_VERSION 4.6.3

WORKDIR /app

# Install
RUN     apk update && \
        apk upgrade && \
        # Install require packages
        apk add --no-cache curl ca-certificates libcap \
                php7 php7-session \
                php7-mongodb \
                php7-pdo_dblib \
                php7-pdo_mysql \
                php7-pdo_odbc \
                php7-pdo_pgsql \
                php7-pdo_sqlite \
                php7-sqlite3 && \
        # Install Adminer
        curl https://www.adminer.org/static/download/${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -s -S -o adminer.php && \
        # Install plugins (defined in adminer-with-plugins.php)
        mkdir plugins && \
        curl https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php -s -S -o plugins/plugin.php && \
        curl https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-bz2.php -s -S -o plugins/dump-bz2.php && \
        curl https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-password-less.php -s -S -o plugins/login-password-less.php && \
        # Style
        curl https://raw.githubusercontent.com/vrana/adminer/master/designs/pepa-linha/adminer.css -s -S -o adminer.css && \
        # Allow PHP to run as a service
        setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/php7 && \
        # Clean
        apk del libcap curl ca-certificates && \
        rm -rf /var/cache/apk/*

COPY    adminer-with-plugins.php index.php
RUN     chown -R adminer:adminer /app

EXPOSE   80

USER     adminer
CMD      ["/usr/bin/php7", "-S", "0.0.0.0:80", "-t", "/app"]
