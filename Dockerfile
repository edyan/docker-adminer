FROM    alpine:3.9

ARG     ADMINER_VERSION=4.7.6

RUN     mkdir -p /app
WORKDIR /app

# Install
RUN     apk update \
&&      apk upgrade \
        # Install require packages
&&      apk add --no-cache curl ca-certificates libcap \
                php7 \
                php7-mongodb \
                php7-pdo_dblib \
                php7-pdo_mysql \
                php7-pdo_odbc \
                php7-pdo_pgsql \
                php7-pdo_sqlite \
                php7-session \
                php7-simplexml \
                php7-sqlite3 \
        # configure PHP
&&      sed -i 's/upload_max_filesize.*=.*/upload_max_filesize = 256M/g' /etc/php7/php.ini \
&&      sed -i 's/post_max_size.*=.*/post_max_size = 256M/g' /etc/php7/php.ini \
        # Install Adminer
&&      curl https://www.adminer.org/static/download/${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -s -S -o adminer.php \
        # Install plugins (defined in adminer-with-plugins.php)
&&      mkdir plugins \
&&      curl https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php -s -S -o plugins/plugin.php \
&&      curl https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-bz2.php -s -S -o plugins/dump-bz2.php \
&&      curl https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-password-less.php -s -S -o plugins/login-password-less.php \
        # Style
&&      curl https://raw.githubusercontent.com/vrana/adminer/master/designs/pepa-linha/adminer.css -s -S -o adminer.css \
        # Allow PHP to run as a service
&&      setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/php7 \
        # Clean
&&      apk del curl ca-certificates libcap \
&&      rm -rf /var/cache/apk/*

COPY    adminer-with-plugins.php index.php

# At the end as it changes everytime ;)
ARG         BUILD_DATE
ARG         DOCKER_TAG
ARG         VCS_REF
LABEL       maintainer="Emmanuel Dyan <emmanueldyan@gmail.com>" \
            org.label-schema.build-date=${BUILD_DATE} \
            org.label-schema.name=${DOCKER_TAG} \
            org.label-schema.description="Docker Adminer Image based on Alpine and including a few plugins" \
            org.label-schema.url="https://cloud.docker.com/u/edyan/repository/docker/edyan/adminer" \
            org.label-schema.vcs-url="https://github.com/edyan/docker-adminer" \
            org.label-schema.vcs-ref=${VCS_REF} \
            org.label-schema.schema-version="1.0" \
            org.label-schema.vendor="edyan" \
            org.label-schema.docker.cmd="docker run -d --rm ${DOCKER_TAG}"

# Setup app user
RUN     addgroup adminer \
&&      adduser -s /sbin/halt -h /app -D -G adminer adminer \
&&      chown -R adminer:adminer /app

EXPOSE  80

USER    adminer
CMD     ["/usr/bin/php7", "-S", "0.0.0.0:80", "-t", "/app"]
