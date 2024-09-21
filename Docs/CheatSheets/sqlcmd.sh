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



sqlcmd -S <server> -U <username> -P <password>
sqlcmd -S localhost,1433 -U sa -P 'P@ssw0rd123!'

SELECT name FROM sys.databases;
GO



CREATE DATABASE MyDatabase;
GO

USE MyDatabase;
GO

CREATE TABLE Users (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Email NVARCHAR(50)
);
GO


INSERT INTO Users (ID, Name, Email) VALUES (1, 'John Doe', 'john@example.com');
GO

SELECT * FROM Users;
GO


SELECT DB_NAME();
GO

SELECT * FROM sys.tables;
GO


sqlcmd -S localhost,1433 -U sa -P 'P@ssw0rd123!' -Q "SELECT name FROM sys.databases"


# Workflow example
sqlcmd -S localhost,1433 -U sa -P 'P@ssw0rd123!'
CREATE DATABASE MyNewDatabase;
GO
USE MyNewDatabase;
GO
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(50),
    Price DECIMAL(10, 2)
);
GO
INSERT INTO Products (ProductID, ProductName, Price) VALUES (1, 'Laptop', 999.99);
GO
SELECT * FROM Products;
GO
QUIT

