FROM nginx:latest

WORKDIR /data

COPY nginx.conf /etc/nginx/nginx.conf

COPY . .


# If you add a custom CMD in the Dockerfile, 
# be sure to include -g daemon off;

# example worked
