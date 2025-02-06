
apt-get update && apt-get upgrade -y
apt-get install curl -y

# install k3s
echo "Installing k3s . . ."

export INSTALL_K3S_EXEC="server --node-external-ip='192.168.56.110' --bind-address='192.168.56.110' --flannel-iface=eth1 --write-kubeconfig-mode 644"

curl -sfL https://get.k3s.io | sh -
if [ $? -ne 0 ]; then
    echo "Failed to install k3s."
    exit 1
fi

echo "Successfully installed K3s."

cp /var/lib/rancher/k3s/server/node-token /shared_folder/node-token
cp /etc/rancher/k3s/k3s.yaml /shared_folder/k3s.yaml
mkdir /home/vagrant/.kube
cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
