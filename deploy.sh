pwd
ls
docker stop www-web
docker rm www-web
docker rmi react/www-web
docker build -t react/www-web .
docker run -d --name www-web -p 3000:3000 react/www-web