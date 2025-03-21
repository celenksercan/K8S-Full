#!/bin/bash
set -e

echo "[1/5] Gerekli bağımlılıklar yükleniyor..."
sudo apt update
sudo apt install -y curl apt-transport-https ca-certificates gnupg

echo "[2/5] GPG anahtarı ekleniyor..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | \
  sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "[3/5] Kubernetes APT deposu ekleniyor..."
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | \
  sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null

echo "[4/5] APT önbelleği güncelleniyor..."
sudo apt update

echo "[5/5] Kubernetes bileşenleri yükleniyor (kubelet, kubeadm, kubectl)..."
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "✅ Kubernetes (v1.28) başarıyla yüklendi."
