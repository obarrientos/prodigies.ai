# Variables
$serverName = "MySQLServer"
$adminUsername = "azureadmin"
$adminPassword = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force
$databaseName = "MyDatabase"

# Create a SQL Server
New-AzSqlServer -ResourceGroupName $resourceGroup -Location $location -ServerName $serverName -SqlAdministratorCredentials `
    (New-Object System.Management.Automation.PSCredential($adminUsername, $adminPassword))

# Create a SQL Database
New-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $serverName -DatabaseName $databaseName -Edition "Basic"
