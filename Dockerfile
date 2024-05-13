# Use nginx as base image
FROM nginx:alpine

# Copy the HTML file into the nginx html directory
COPY index.html /usr/share/nginx/html/

# Expose port 8181
EXPOSE 8181