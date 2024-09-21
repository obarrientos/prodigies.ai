curl -sfL https://get.k3s.io | K3S_URL=https://<MASTER_NODE_IP>:6443 K3S_TOKEN=<NODE_TOKEN> sh -
sudo cat /var/lib/rancher/k3s/server/node-token
kubectl get nodes
kubectl get pods -o wide
kubectl apply -f app-deployment.yaml