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

