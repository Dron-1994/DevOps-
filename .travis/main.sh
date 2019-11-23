#!/bin/bash

# вывод ошибок
set -o errexit

main() {
  setup_dependencies
  update_docker_configuration

  echo "SUCCESS:
  Done! Finished setting up Travis machine.
  "
}

# обновляем пакеты, устанавливаем python, python-pip и обновляем docker-ce

setup_dependencies() {
  echo "INFO:
  Setting up dependencies.
  "

  sudo apt update -y
  sudo apt install realpath python python-pip -y
  sudo apt install --only-upgrade docker-ce -y

  sudo pip install docker-compose || true

  docker info
  docker-compose --version
}

#настраиваем конфигурацию демона, перезапускаем докер
update_docker_configuration() {
  echo "INFO:
  Updating docker configuration
  "

  echo '{
  "experimental": true,
  "storage-driver": "overlay2",
  "max-concurrent-downloads": 50,
  "max-concurrent-uploads": 50
}' | sudo tee /etc/docker/daemon.json
  sudo service docker restart
}

main
