# Use nginx as base image
FROM nginx:alpine

# Copy the custom Nginx configuration file
COPY my-custom.conf /etc/nginx/conf.d/default.conf

# Set the working directory in the container
WORKDIR /var/www/html

# COPY index.html /usr/share/nginx/html/
# Copy the rest of the application code
COPY . /var/www/html/

# Expose port 8181 (optional)
EXPOSE 8181
