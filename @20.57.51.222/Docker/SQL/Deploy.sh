# Version
docker --version

docker ps -a       

# Delete Container
docker rm -f sqlserver-express     

# Pull Image and Run Image
docker run --platform linux/amd64 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=P@ssw0rd123!' -p 1433:1433 --name sqlserver-express -d mcr.microsoft.com/mssql/server:2019-latest


# Check Container Logs (Optional): If you want to check the SQL Server container logs for additional information or troubleshoot any issues, run:
docker logs sqlserver-express

# Interact with the SQL Server Container: If you want to open a bash shell inside the running container, use:
docker exec -it sqlserver-express /bin/bash


# Step 1: Tag your local image:
docker tag mcr.microsoft.com/mssql/server:2019-latest sqlserver-express:v1
# Step 2: Push to a Container Registry (e.g., Docker Hub or Azure Container Registry):
docker login
docker tag sqlserver-express:v1
docker push sqlserver-express:v1

# Step 2: Write the Kubernetes Deployment YAML for SQL Server Express
# sqlserver-deployment.yaml

# Step 3: Deploy the YAML to the K3s Cluster on Your Azure VM
ssh 20.57.51.222 -l aiadmin -p P@ssw0rd123!
kubectl apply -f sqlserver-deployment.yaml

# Step 4: Verify the Deployment
kubectl get pods
kubectl get services


# Troubleshooting:
# kubectl logs <pod-name>