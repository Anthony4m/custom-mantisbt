FROM php:7.3-apache

RUN chmod 1777 /tmp

RUN rm -f /etc/apt/apt.conf /etc/apt/apt.conf.d/*

RUN apt-get update

COPY . /var/www/html/mantis

COPY ./mantis.conf /etc/apache2/sites-available/

WORKDIR /var/www/html/mantis

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN apt-get update && apt install sudo -y

RUN sudo a2ensite mantis.conf

RUN sudo a2dissite 000-default.conf

RUN service apache2 restart

RUN sudo chown -HR www-data:www-data /var/www/html/mantis/

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

EXPOSE 80