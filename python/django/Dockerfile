# Base image
FROM ubuntu:latest

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3-pip python3-dev libpq-dev && \
    apt-get install -y apache2 apache2-dev

# Create and set the working directory
RUN mkdir /app
WORKDIR /app

# Copy the requirements file and install Python dependencies
COPY requirements.txt /app/
RUN pip3 install -r requirements.txt

# Copy the Django application code
COPY . /app/

# Run migrations and collect static files
RUN python3 manage.py migrate && python3 manage.py collectstatic --noinput

# Configure Apache
COPY ./apache/django.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod wsgi

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apachectl", "-D", "FOREGROUND"]

