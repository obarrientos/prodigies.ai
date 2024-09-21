docker exec -it sqlserver-express /bin/bash):

# Run these commands inside the container (after running docker exec -it sqlserver-express /bin/bash):
apt-get update
apt-get install -y curl gnupg2
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev mssql-tools


# Add sqlcmd to the path:
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc

# Run SQL Commands using sqlcmd:
sqlcmd -S localhost -U sa -P 'P@ssw0rd123!'

# SQL queries
SELECT name FROM sys.databases;
GO