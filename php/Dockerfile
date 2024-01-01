FROM ubuntu
LABEL maintainer="Simon <simonlucky.o@protonmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y apache2 ghostscript libapache2-mod-php php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-zip php-xml php-mysql

ENV SERVER_NAME localhost
ENV APACHE_DOCUMENT_ROOT /var/www/html/wordpress

RUN echo "ServerName $SERVER_NAME" >> /etc/apache2/apache2.conf
 
# Other enviroment variable 
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2

RUN mkdir -p $APACHE_DOCUMENT_ROOT

RUN sed -i "s|DocumentRoot /var/www/html|DocumentRoot $APACHE_DOCUMENT_ROOT|" /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite

EXPOSE 80

ENTRYPOINT ["apachectl", "-D", "FOREGROUND"]
