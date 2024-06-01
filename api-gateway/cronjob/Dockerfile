# Use a lightweight Python base image
FROM python:alpine

# Install cron
RUN apk add --no-cache curl bash

# Install requests library
RUN pip install requests

WORKDIR /app

COPY start.sh start.sh

# Copy the Python script into the container
COPY get_key.py get_key.py

# Add a crontab entry
RUN echo "0 * * * * /usr/local/bin/python /app/get_key.py >> /var/log/cron.log 2>&1" > /etc/crontabs/root

# Start cron in the foreground
CMD ["/app/start.sh"]
