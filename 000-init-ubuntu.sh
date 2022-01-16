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

echo *** Скачиваем docker-compose v2.2.2 

sudo curl -L "https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose

# ставим права

sudo chmod +x /usr/local/bin/docker-compose

# проверяем что оно работает

docker-compose --version

# устанавливаем нужное для k8s

# ключик

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

# добавляем репу

sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

# ставим куски кубика

sudo apt install -y kubeadm kubelet kubectl kubernetes-cni

# отключаем swap

sudo swapoff --all

# комментирование /etc/fstab

sudo sed -i '/ swap / s/^/#/' /etc/fstab

# удалем сам файл swap чтобы не занимал место

sudo rm -f /swap.img

# чтобы эта хрень заработала иначе будет не пойми что твориться (cgroup для докер)

sudo cp daemon.json /etc/docker/daemon.json

sudo systemctl daemon-reload

sudo systemctl restart docker

sudo systemctl restart kubelet
