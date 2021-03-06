#!/bin/bash

# чтобы заработал flannel

sudo mkdir /run/flannel/

sudo cp subnet.env /run/flannel/subnet.env

# стартуем кластер

sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# если забыли записать строчку с join - перегенирируйте следующией командой которая закомментирована

# kubeadm token create --print-join-command

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

# если вдруг хотите вместо flannel что-то другое то вот cilium для примера

#kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.9/install/kubernetes/quick-install.yaml

# молимся

