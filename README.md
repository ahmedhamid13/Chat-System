docker-compose build
MYSQL_ROOT_PASSWORD=admin docker-compose up

docker-compose run web rails <>
docker-compose run web rake db:create
docker-compose run web rake db:migrate

PostMan_URL: https://documenter.getpostman.com/view/12318086/UVRGDP8s
