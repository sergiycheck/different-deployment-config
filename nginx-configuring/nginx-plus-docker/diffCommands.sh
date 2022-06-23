# run nginx in docker 
# exec docker run --name mynginx1 -p 4042:80 -d nginx

# run nginx-static-sample:latest in docker 
# exec docker run --name nginx-static1 -p 4042:80 -d nginx-static-sample:latest

# run nginx with bind mound volume
# exec docker run --rm  -it --name nginx-static1 \
# -p 4042:80 \
# -v $PWD/nginx-static-serving/logs:/var/log/nginx \
# nginx-static-sample:latest

# run nginx-proxy-static:latest in docker 
exec docker run --rm  -it --name nginx-proxy-static \
-p 4042:80 \
-v $PWD/nginx-proxy-static/logs:/var/log/nginx \
nginx-static-sample:latest