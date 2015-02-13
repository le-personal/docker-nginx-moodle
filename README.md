# Docker image with Nginx and PHP 5.5.9 optimized for Moodle
This image is build using Ubuntu 14.04 with Nginx and PHP 5.5.9 and is optimized to run Moodle.

Includes:

- nginx
- php
- composer

Important:

- Logs are at /var/log/supervisor so you can map that directory
- Application root directory is /var/www so make sure you map the application there
- Moodle files are mapped to /var/files so make sure you mount that volume
- Nginx configuration was provided by https://github.com/perusio/drupal-with-nginx but it's modified

## To build

    $ make build

    or

    $ docker build -t yourname/nginx-moodle .


## To run
Nginx will look for files in /var/www so you need to map your application to that directory.

    $ docker run -d -p 8000:80 -v application:/var/www -v files:/var/files yourname/nginx-moodle

If you want to link the container to a MySQL/MariaDB contaier do:

    $ docker run -d -p 8000:80 -v application:/var/www -v -v files:/var/files my_mysql_container:mysql yourname/nginx-moodle

The startup.sh script will add the environment variables with MYSQL_ to /etc/php5/fpm/pool.d/env.conf so PHP-FPM detects them. If you need to use them you can do:
<?php getenv("SOME_ENV_VARIABLE_THAT_HAS_MYSQL_IN_THE_NAME"); ?>

## Fig

    mysql:
      image: mysql
      expose:
        - "3306"
      environment:
        MYSQL_ROOT_PASSWORD: 123
    web:
      image: iiiepe/nginx-moodle
      volumes:
        - application:/var/www
        - logs:/var/log/supervisor
        - files:/var/files
      ports:
        - "80:80"
      links:
        - "mysql:mysql"

## Running Drush
With Fig this is actually easier and is the recommended way since if you're running Docker without fig, you'll have to link all containers before you run drush.

    $ fig run --rm web drush

### License
Released under the MIT License.
