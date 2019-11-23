FROM ubuntu:18.04

#поле не обязательное, указывает кто автор
MAINTAINER dron  <dronbarabash2637@gmail.com>


#Так как не всепакеты доступны в стандартных репозиториях, то добавляю в sources.list нужные записи
RUN  echo -e "deb http://archive.ubuntu.com/ubuntu bionic main universe\ndeb http://archive.ubuntu.com/ubuntu bionic-security main universe\ndeb http://archive.ubuntu.com/ubuntu bionic-updates main universe" >> /etc/apt/sources.list

#обновляем пакеты
RUN apt-get update


#переходив в рабочую дерикторию(выбрал ту, в которой я работаю
WORKDIR /home/dron/DevOps-git

#для коректной работы устанавливаем  apache2, php и БД
RUN apt-get install apache2 libapache2-mod-php
RUN apt-get install php php-pear php-cgi php-common libapache2-mod-php php-mbstring php-net-socket php-gd php-xml-util php-mysql php-gettext php-bcmath
RUN apt-get install mariadb-server

#репозеторий Zabbix
RUN wget https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-2+bionic_all.deb
RUN dpkg -i zabbix-release_4.0-2+bionic_all.deb

#устанавливаем сам Zabbix-сервер
RUN apt-get update
RUN apt-get install zabbix-server-mysql zabbix-frontend-php zabbix-agent zabbix-get

#открываем порты(не уверен все ли порты указал)
EXPOSE 10051:10051
