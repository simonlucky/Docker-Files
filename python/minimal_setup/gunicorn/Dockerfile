# Base image
FROM ubuntu:latest

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3-pip python3-dev libpq-dev

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

# Expose port 8000
EXPOSE 8000

# Start Gunicorn
CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8000", "app.wsgi:application"]

