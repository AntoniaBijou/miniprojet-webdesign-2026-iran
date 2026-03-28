FROM php:8.2-fpm

# Dependencies for PHP extensions and tools
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libzip-dev \
    libonig-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install pdo_pgsql pgsql bcmath mbstring pcntl zip gd \
  && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . /var/www/html

RUN composer install --no-interaction --optimize-autoloader && \
    php artisan key:generate --ansi --force && \
    chown -R www-data:www-data /var/www/html

EXPOSE 9000
CMD ["php-fpm"]
