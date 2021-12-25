#!/bin/bash

# чтобы эта хрень заработала

sudo cp daemon.json /etc/docker/daemon.json

sudo systemctl daemon-reload

sudo systemctl restart docker

sudo systemctl restart kubelet

# чтобы заработал flannel

mkdir /run/flannel/

sudo cp subnet.env /run/flannel/subnet.env

# стартуем кластер

sudo kubeadm init --pod-network-cidr=10.244.0.0/16

echo *** !!!                               !!! ***
echo *** !!! Внимание скопируй join-строку !!! ***
echo *** !!!                               !!! ***

# копируем настройки чтобы kubectl работал

mkdir -p $HOME/.kube

sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Разрешаем запускать поды на мастере

kubectl taint nodes --all node-role.kubernetes.io/master-

# flannel

sudo sysctl net.bridge.bridge-nf-call-iptables=1

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml

# молимся

