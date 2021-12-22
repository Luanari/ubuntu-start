#!/bin/bash

# установите несколько необходимых пакетов, которые позволяют apt использовать пакеты через HTTPS:

sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# добавить ключ GPG для официального репозитория Docker в вашу систему:

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# добавить репозиторий Docker в источники APT:

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# понятно

sudo apt update

# устанавливаем

sudo apt install -y  docker-ce

# добавляем текущего пользователя в группу docker

sudo gpasswd -a $USER docker

# качаем docker-compose 

echo *** скачиваем docker-compose v2.2.2

sudo curl -L "https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose

# ставим права

sudo chmod +x /usr/local/bin/docker-compose

# проверяем что оно работает

docker-compose --version

# качаем kubectl 

echo *** Скачиваем kubectl

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

# делаем исполняемым

chmod +x ./kubectl

# отправляем в папку предназначенную для этого

sudo mv ./kubectl /usr/local/bin/kubectl

# проверяем что сработало

kubectl version --client






