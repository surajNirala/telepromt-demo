# Use nginx as base image
FROM nginx:alpine

# Copy the custom Nginx configuration file
COPY my-custom.conf /etc/nginx/conf.d/default.conf

# Copy the HTML file into the nginx html directory
COPY index.html /usr/share/nginx/html/

# Expose port 8181 (optional)
EXPOSE 8181
