docker login
# 1. Pull the Artifactory image:
docker pull docker.bintray.io/jfrog/artifactory-oss:latest
# 2. Tag the image:
docker tag docker.bintray.io/jfrog/artifactory-oss:latest Artifactory:v1
# 3. Push the image:
docker push JFrog:v1
# 4. Create a Kubernetes deployment YAML file:
#  artifactory-deployment.yaml
# 5. Deploy to K3s:
kubectl apply -f artifactory-deployment.yaml
# 6. Check if the pod is running:
kubectl get pods
# 7. Access JFrog Artifactory:
kubectl get svc

# Look for the NodePort under artifactory-service. For example, if the NodePort is 30080, you can access Artifactory via http://<your-vm-ip>:30080.

