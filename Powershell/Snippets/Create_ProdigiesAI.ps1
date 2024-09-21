# Variables
$resourceGroup = "Prodigies_ResourceGroup"
$location = "EastUS2"
$vnetName = "Prodigies-VNet"
$subnetName = "default"
$publicIpName = "Prodigies-PublicIP"
$nsgNamePublic = "NSG-Public-VM"
$nsgNamePrivate = "NSG-Private-VM"
$adminUsername = "prodigy"
$adminPassword = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($adminUsername, $adminPassword)

# VM1 (Public-facing) Details - Call it "Zeus"
$vmNamePublic = "Zeus-VM"
$vmSize = "Standard_D2s_v4"

# VM2 (Private, Vault and Databases) Details - Call it "Hades"
$vmNamePrivate = "Hades-VM"
$vmSizePrivate = "Standard_D2s_v4"

# Enable verbose output for all subsequent commands
$VerbosePreference = "Continue"

$nicNamePublic = "$vmNamePublic-NIC"
$ipConfigName = "$vmNamePublic-IPConfig"

$nicNamePrivate = "$vmNamePrivate-NIC"
$ipConfigPrivateName = "$vmNamePrivate-IPConfig"

# 1. Create Resource Group
Write-Verbose "Creating Resource Group..."
# New-AzResourceGroup -Name $resourceGroup -Location $location
# New-AzResourceGroup -Name "Prodigies_ResourceGroup" -Location "EastUS2"


# 2. Create Virtual Network and Subnet
Write-Verbose "Creating Virtual Network and Subnet..."        
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name $vnetName -AddressPrefix "10.0.0.0/16" -Force
$subnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.0.0/24" -VirtualNetwork $vnet
$vnet | Set-AzVirtualNetwork

# 3. Create Public IP Address for Public-facing VM (Zeus-VM)
Write-Verbose "Creating Public IP for Public-facing VM..."
$publicIp = New-AzPublicIpAddress -ResourceGroupName $resourceGroup -Name $publicIpName -Location $location -AllocationMethod Static -Sku Standard -Force

# 4. Create Network Security Group for Public VM (Zeus-VM)
Write-Verbose "Creating Network Security Group for Public-facing VM..."
$nsgPublic = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location -Name $nsgNamePublic -Force


# 5. Add Inbound Rules to Allow SSH and HTTP/HTTPS Traffic on the Public VM (Zeus-VM)
Write-Verbose "Adding security rules to NSG for Public-facing VM..."
$nsgRuleSSH = New-AzNetworkSecurityRuleConfig -Name "Allow-SSH" -Description "Allow SSH" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 22
$nsgRuleHTTP =New-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Description "Allow HTTP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 80

# Apply the rules to the NSG for Public VM
$nsgPublic.SecurityRules.Add($nsgRuleSSH)
$nsgPublic.SecurityRules.Add($nsgRuleHTTP)
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsgPublic

# 6. Create Network Security Group for Private VM (Hades-VM)
Write-Verbose "Creating Network Security Group for Private VM..."
$nsgPrivate = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location -Name $nsgNamePrivate -Force

# 7. Add a Rule to Allow Only Subnet Traffic to the Private VM (Hades-VM)
Write-Verbose "Adding subnet access rule to NSG for Private VM..."
$nsgRuleSubnetAccess = New-AzNetworkSecurityRuleConfig -Name "Allow-Subnet-Access" -Description "Allow Subnet Access" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix "VirtualNetwork" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "*"

# Apply the rule to the NSG for Private VM
$nsgPrivate.SecurityRules.Add($nsgRuleSubnetAccess)
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsgPrivate

# 8. Create NIC for Public-facing VM (Zeus-VM)
Write-Verbose "Creating NIC for Public-facing VM..."
$Subnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup 
$ipConfig = New-AzNetworkInterfaceIpConfig -Name $ipConfigName -SubnetId $Subnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id 
$nicPublic = New-AzNetworkInterface -ResourceGroupName $resourceGroup -Location $location -Name $nicNamePublic -IpConfiguration $ipConfig -Force

# 9. Create NIC for Private VM (Hades-VM)
Write-Verbose "Creating NIC for Private VM..."
$ipConfigPrivate = New-AzNetworkInterfaceIpConfig -Name $ipConfigPrivateName -SubnetId $Subnet.Subnets[0].Id  -PrivateIpAddress 10.0.0.5 
$nicPrivate = New-AzNetworkInterface -ResourceGroupName $resourceGroup -Location $location -Name $nicNamePrivate -IpConfiguration $ipConfigPrivate -NetworkSecurityGroup $nsgPrivate -Force

# 10. Create the Public-facing VM (Zeus-VM) with Kubernetes (K3s)
Write-Verbose "Creating Public-facing VM (Zeus-VM) and installing Kubernetes (K3s)..."

$UserDataStr = @'
#!/bin/bash
sudo apt-get update

# Install NGINX as a reverse proxy
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Install Kubernetes (K3s for lightweight Kubernetes)
curl -sfL https://get.k3s.io | sh -
sudo systemctl start k3s
sudo systemctl enable k3s

# Confirm Kubernetes (K3s) installation
k3s kubectl get nodes

# Optionally install any other tools needed for managing Kubernetes
echo "Kubernetes (K3s) is up and running on Zeus-VM"
'@


$userDataPublicVM = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($UserDataStr))
New-AzVM -ResourceGroupName $resourceGroup -Location $location -Name $vmNamePublic -Size $vmSize -Credential $credential -ImageName "Canonical:UbuntuServer:18.04-LTS:latest" -UserData $userDataPublicVM -Verbose

# Create UserData value
$UserDataStr = @'
#!/bin/bash
sudo apt-get update

# Install and Configure HashiCorp Vault
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vault
echo "listener \"tcp\" { address = \"0.0.0.0:8200\" tls_disable = 1 }" | sudo tee /etc/vault.d/config.hcl
echo "storage \"file\" { path = \"/var/lib/vault/data\" }" | sudo tee -a /etc/vault.d/config.hcl
sudo systemctl start vault
sudo systemctl enable vault
export VAULT_ADDR="http://127.0.0.1:8200"
vault operator init -key-shares=1 -key-threshold=1 > /home/azureuser/vault-init.txt

# Install MongoDB
sudo apt-get install -y mongodb
sudo systemctl start mongodb
sudo systemctl enable mongodb

# Install MariaDB
sudo apt-get install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Install PostgreSQL
sudo apt-get install -y postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Install SQL Server Express
curl -s https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(curl -s https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list)"
sudo apt-get update && sudo apt-get install -y mssql-server
sudo /opt/mssql/bin/mssql-conf setup
sudo systemctl start mssql-server
sudo systemctl enable mssql-server

# Install ELK Stack (Elasticsearch, Logstash, Kibana)
sudo apt-get install -y openjdk-11-jdk
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-add-repository "deb https://artifacts.elastic.co/packages/7.x/apt stable main"
sudo apt-get update && sudo apt-get install -y elasticsearch logstash kibana
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch
sudo systemctl start logstash
sudo systemctl enable logstash
sudo systemctl start kibana
sudo systemctl enable kibana

# Install Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# Install Blob Storage (MinIO for S3-compatible object storage)
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
sudo mv minio /usr/local/bin
sudo mkdir -p /mnt/data
sudo minio server /mnt/data --console-address ":9001" &

# Install Keycloak
echo "Installing Keycloak"
sudo apt-get install -y openjdk-11-jdk
wget https://github.com/keycloak/keycloak/releases/download/20.0.1/keycloak-20.0.1.tar.gz
tar -xvzf keycloak-20.0.1.tar.gz
sudo mv keycloak-20.0.1 /opt/keycloak
sudo groupadd keycloak
sudo useradd -r -g keycloak -d /opt/keycloak -s /sbin/nologin keycloak
sudo chown -R keycloak:keycloak /opt/keycloak
sudo -u keycloak /opt/keycloak/bin/kc.sh build
echo "Starting Keycloak"
sudo -u keycloak nohup /opt/keycloak/bin/kc.sh start --http-port=8081 &
echo "Keycloak is running on port 8081"

echo "All services are up and running"
'@;


$userDataPrivateVM = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($UserDataStr))


# 11. Create the Private VM (Hades-VM) and Install HashiCorp Vault, Databases, and Other Services
Write-Verbose "Creating Private VM (Hades-VM) and installing HashiCorp Vault and other services..."
New-AzVM -ResourceGroupName $resourceGroup -Location $location -Name $vmNamePrivate -Size $vmSizePrivate  -Credential $credential -ImageName "Canonical:UbuntuServer:18.04-LTS:latest" -UserData $userDataPrivateVM -Verbose
