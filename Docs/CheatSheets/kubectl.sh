# Join a worker node to the K3s cluster using the master node's IP and token
curl -sfL https://get.k3s.io | K3S_URL=https://<MASTER_NODE_IP>:6443 K3S_TOKEN=<NODE_TOKEN> sh -

# Display the K3s server node token, required to add new worker nodes
sudo cat /var/lib/rancher/k3s/server/node-token

# Apply the configuration in the cronjob.yaml file to the cluster
kubectl apply -f cronjob.yaml

# Apply the configuration in the app-deployment.yaml file to the cluster
kubectl apply -f app-deployment.yaml

# Create a generic secret from literal key-value pairs or file content
kubectl create secret generic <secret-name> --from-literal=<key>=<value> --from-file=<filename>

# Create a namespace
kubectl create namespace <namespace-name>

# Delete all pods in the specified namespace
kubectl delete pods --all -n <namespace>

# Delete a cronjob
kubectl delete cronjob <cronjob-name>

# Delete a deployment in the specified namespace
kubectl delete deployment <deployment-name> -n <namespace>

# Delete a namespace
kubectl delete namespace <namespace-name>

# Delete a pod in the specified namespace
kubectl delete pod <pod-name> -n <namespace>

# Delete a service in the specified namespace
kubectl delete service <service-name> -n <namespace>

# Delete a resource defined in a yaml file
kubectl delete -f <archivo.yaml>

# Describe a cronjob in the specified namespace
kubectl describe cronjob <cronjob-name> -n <namespace>

# Describe a node
kubectl describe node <node-name>

# Describe a pod in the specified namespace
kubectl describe pod <pod-name> -n <namespace>

# Describe a role in the specified namespace
kubectl describe role <role-name> -n <namespace>

# Execute a command inside a container of a pod in the specified namespace
kubectl exec -it <pod-name> -n <namespace> -- /bin/bash

# Get all resources in the specified namespace and output them to a yaml file
kubectl get all -n <namespace> -o yaml > recursos.yaml

# Get all resources in the specified namespace
kubectl get all -n <namespace>

# Get cronjobs in the specified namespace
kubectl get cronjobs -n <namespace>

# Get events, sorted by creation timestamp
kubectl get events --sort-by='.metadata.creationTimestamp'

# Get events for a specific pod
kubectl get events --field-selector involvedObject.name=<pod-name>

# Get jobs in the specified namespace
kubectl get jobs -n <namespace>

# Get logs of a pod in the specified namespace
kubectl logs <pod-name> -n <namespace>

# Get logs from all containers in a pod in the specified namespace
kubectl logs <pod-name> --all-containers=true -n <namespace>

# Get namespaces in the cluster
kubectl get namespaces

# Get nodes in the cluster
kubectl get nodes

# Get pods in the specified namespace
kubectl get pods -n <namespace>

# Get pods with a specific label
kubectl get pods -l app=<label>

# Get pods and output them in json format
kubectl get pods -n <namespace> -o json

# Get pods and output them in yaml format
kubectl get pods -n <namespace> -o yaml

# Get services with detailed information
kubectl get svc -o wide

# Get a specific service in the specified namespace
kubectl get svc <service-name> -n <namespace>

# Get roles in the specified namespace
kubectl get roles -n <namespace>

# Get rolebindings in the specified namespace
kubectl get rolebindings -n <namespace>

# Restart a deployment in the specified namespace
kubectl rollout restart deployment <deployment-name> -n <namespace>

# Show the history of rollouts for a deployment in the specified namespace
kubectl rollout history deployment <deployment-name> -n <namespace>

# Scale a deployment to a specific number of replicas
kubectl scale deployment <deployment-name> --replicas=<num>

# Show the top nodes by resource usage
kubectl top nodes

# Show the top pods by resource usage in the specified namespace
kubectl top pod <pod-name> -n <namespace>

# Edit the configuration of a running deployment
kubectl edit deployment <deployment-name>

# Expose a deployment as a service with a NodePort
kubectl expose deployment <deployment-name> --type=NodePort --port=<port-number>

# Get the current context (current Kubernetes cluster and namespace)
kubectl config current-context

# View the Kubernetes config file
kubectl config view

# Switch to a different context
kubectl config use-context <context-name>
