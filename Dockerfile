FROM php:8.1-apache

# Instalar dependencias necesarias para Composer y git
RUN apt-get update && apt-get install -y \
    unzip \
    libsqlite3-dev \
    libonig-dev \
    git

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copiar el archivo de configuración de Apache
COPY config/apache/apache.conf /etc/apache2/sites-available/000-default.conf

# Habilitar mod_rewrite de Apache
RUN a2enmod rewrite

# Copiar el archivo de configuración de PHP
COPY config/php/php.ini /usr/local/etc/php/php.ini

# Crear directorios de logs
RUN mkdir -p /var/log/php /var/log/apache2

WORKDIR /var/www/html

CMD ["apache2-foreground"]
