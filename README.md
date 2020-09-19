# Processmaker-3.4.11
Install Processmaker on docker :

Clone Processmaker on your system and run docker compose
````
git clone https://github.com/sermajid/processmaker-3.4.11.git
cd processmaker-3.4.11
docker-compose up -d
````
if you need to mysql, change the docker-compose.yml to :
````
version: "3"
services:
  processmaker:
    build: .
    ports:
      - "8001:80"
    volumes:
      - proceessmaker_data:/opt/processmaker
    
  mariadb:
    image: linuxserver/mariadb
    container_name: mysql
    environment:
      MYSQL_ROOT_PASSWORD: mypassword
      MYSQL_DATABASE: my_db
      MYSQL_USER: myuser
      MYSQL_PASSWORD: mypassword
      PUID: 1000
      PGID: 1000
    ports:
      - "3306:3306"
    volumes:
      - myqsl:/config


  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: phpmyadmin
    links:
      - mariadb
    environment:
      PMA_HOST: mariadb
      PMA_PORT: 3306
      PMA_ARBITRARY: 1
    restart: always
    ports:
      - 8081:80
volumes:
  proceessmaker_data:
  myqsl:
````