# Processmaker-3.4.11
### Install ProcessMaker on docker :

Clone ProcessMaker on your system and run docker compose
````
git clone https://github.com/majidfeiz/processmaker-3.4.11.git
cd processmaker-3.4.11
docker-compose up -d
````
Open your ProcessMaker on port 8001

<hr>

## Install Processmaker on docker with mysql and phpmyadmin:
If you need to mysql, change the docker-compose.yml to :
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
Open your processmaker on port 8001 and open your phpmyadmin on port 8081

## Install ProcessMaker
If you change docker-compose like the example above , in the fourth part of installing the program set it like this :
````
Database Engine: MySQL
Host Name: mariadb
Port: 3306
Username: MYSQL_USER (Your mysql username)
Password: MYSQL_PASSWORD (Your mysql password)
````
