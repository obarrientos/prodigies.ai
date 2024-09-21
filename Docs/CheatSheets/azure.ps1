# Create VNet
$resourceGroup = "Prodigies_ResourceGroup"
$location = "East US 2"
$vnetName = "Prodigies-VNet"
$subnetName = "default"
New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name $vnetName -AddressPrefix "10.0.0.0/16" -Subnet `
    @{Name=$subnetName; AddressPrefix="10.0.0.0/24"}

# Delete VM
Remove-AzVM -ResourceGroupName $resourceGroup -Name "MyVMName"


# Delete ResourceGroup
param(
    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
)
Remove-AzResourceGroup -Name $resourceGroupName
Remove-AzResourceGroup -Name "MC_Prodigies_ResourceGroup_Prodigies-Kubernetes-Cluster_eastus2" -Force -AsJob

# Get ResourceGroups
Get-AzResourceGroup

# Automate Resource Cleanup
$vms = Get-AzVM -ResourceGroupName "MyResourceGroup"
foreach ($vm in $vms) {
    if ($vm.Statuses[1].Code -eq "PowerState/deallocated") {
        Remove-AzVM -ResourceGroupName "MyResourceGroup" -Name $vm.Name
    }
}


# Configure LoadBalancing
New-AzLoadBalancerRuleConfig -Name "HTTP" -FrontendIpConfiguration $frontend -BackendAddressPool $backend -Protocol Tcp -FrontendPort 80 -BackendPort 80


# Configure KeyVault
New-AzKeyVault -ResourceGroupName "MyResourceGroup" -VaultName "MyKeyVault" -Location "EastUS"


# Create VM Win
$vmName = "MyWindowsVM"
$adminUsername = "azureuser"
$adminPassword = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force
New-AzVM -ResourceGroupName $resourceGroup -Name $vmName -Location $location -VirtualNetworkName $vnetName -SubnetName $subnetName `
    -SecurityGroupName "MyNetworkSecurityGroup" -PublicIpAddressName "MyPublicIP" -OpenPorts 3389 `
    -Credential (New-Object System.Management.Automation.PSCredential($adminUsername, $adminPassword)) -Image "Win2019Datacenter"


# Backup VM
$backupVault = Get-AzRecoveryServicesVault -ResourceGroupName "MyResourceGroup" -Name "MyBackupVault"
$policy = Get-AzRecoveryServicesBackupProtectionPolicy -VaultId $backupVault.Id -Name "DefaultPolicy"
Enable-AzRecoveryServicesBackupProtection -ResourceGroupName "MyResourceGroup" -Policy $policy -VaultId $backupVault.Id -VMName "MyVM"


# Connect-AzAccount
Connect-AzAccount

# Configure AutoScaling
Add-AzVmssAutoscaleSetting -ResourceGroupName "MyResourceGroup" -VmssName "MyVmss" -MinCount 2 -MaxCount 10 -DefaultCount 3 `
-MetricName "Percentage CPU" -Operator GreaterThan -Threshold 80 -ScaleAction Increase -Cooldown 5


# Delete VNet
$resourceGroupName = "Prodigies_ResourceGroup"
$vnetName = "Prodigies-VNet"
Remove-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName

# Delete PublicIP
$resourceGroupName = "Prodigies_ResourceGroup"
$publicIpName = "Prodigies-PublicIP"
Remove-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Name $publicIpName

# Create LogAnalytics
$resourceGroupName = "Prodigies_ResourceGroup"
$location = "East US 2"
$workspaceName = "Prodigies-LogAnalytics"
New-AzOperationalInsightsWorkspace -ResourceGroupName $resourceGroupName -Name $workspaceName -Location $location -Sku "PerGB2018"


# Create Gateway
$gwipconfig = New-AzVirtualNetworkGatewayIpConfig -Name "MyGatewayIPConfig" -SubnetId $subnet.Id -PublicIpAddressId $publicip.Id
New-AzVirtualNetworkGateway -ResourceGroupName "MyResourceGroup" -Name "MyVNetGateway" -Location "EastUS" -IpConfigurations $gwipconfig -GatewayType Vpn -VpnType RouteBased


# Monitor ResourceUsage
Get-AzMetric -ResourceId "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Compute/virtualMachines/{vm-name}" -MetricNames "Percentage CPU"


# Backup SQL
Backup-AzSqlDatabase -ResourceGroupName "MyResourceGroup" -ServerName "MySqlServer" -DatabaseName "MyDatabase" -BackupName "MyDatabaseBackup"


# Create ProdigiesAI
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
$vmNamePublic = "Zeus-VM"
$vmSize = "Standard_D2s_v4"
$vmNamePrivate = "Hades-VM"
$vmSizePrivate = "Standard_D2s_v4"
$VerbosePreference = "Continue"
$nicNamePublic = "$vmNamePublic-NIC"
$ipConfigName = "$vmNamePublic-IPConfig"
$nicNamePrivate = "$vmNamePrivate-NIC"
$ipConfigPrivateName = "$vmNamePrivate-IPConfig"
Write-Verbose "Creating Resource Group..."
Write-Verbose "Creating Virtual Network and Subnet..."        
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name $vnetName -AddressPrefix "10.0.0.0/16" -Force
$subnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.0.0/24" -VirtualNetwork $vnet
$vnet | Set-AzVirtualNetwork
Write-Verbose "Creating Public IP for Public-facing VM..."
$publicIp = New-AzPublicIpAddress -ResourceGroupName $resourceGroup -Name $publicIpName -Location $location -AllocationMethod Static -Sku Standard -Force
Write-Verbose "Creating Network Security Group for Public-facing VM..."
$nsgPublic = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location -Name $nsgNamePublic -Force
Write-Verbose "Adding security rules to NSG for Public-facing VM..."
$nsgRuleSSH = New-AzNetworkSecurityRuleConfig -Name "Allow-SSH" -Description "Allow SSH" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 22
$nsgRuleHTTP =New-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Description "Allow HTTP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 80
$nsgPublic.SecurityRules.Add($nsgRuleSSH)
$nsgPublic.SecurityRules.Add($nsgRuleHTTP)
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsgPublic
Write-Verbose "Creating Network Security Group for Private VM..."
$nsgPrivate = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location -Name $nsgNamePrivate -Force
Write-Verbose "Adding subnet access rule to NSG for Private VM..."
$nsgRuleSubnetAccess = New-AzNetworkSecurityRuleConfig -Name "Allow-Subnet-Access" -Description "Allow Subnet Access" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix "VirtualNetwork" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "*"
$nsgPrivate.SecurityRules.Add($nsgRuleSubnetAccess)
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsgPrivate
Write-Verbose "Creating NIC for Public-facing VM..."
$Subnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup 
$ipConfig = New-AzNetworkInterfaceIpConfig -Name $ipConfigName -SubnetId $Subnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id 
$nicPublic = New-AzNetworkInterface -ResourceGroupName $resourceGroup -Location $location -Name $nicNamePublic -IpConfiguration $ipConfig -Force
Write-Verbose "Creating NIC for Private VM..."
$ipConfigPrivate = New-AzNetworkInterfaceIpConfig -Name $ipConfigPrivateName -SubnetId $Subnet.Subnets[0].Id  -PrivateIpAddress 10.0.0.5 
$nicPrivate = New-AzNetworkInterface -ResourceGroupName $resourceGroup -Location $location -Name $nicNamePrivate -IpConfiguration $ipConfigPrivate -NetworkSecurityGroup $nsgPrivate -Force
Write-Verbose "Creating Public-facing VM (Zeus-VM) and installing Kubernetes (K3s)..."
$UserDataStr = @'
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
curl -sfL https://get.k3s.io | sh -
sudo systemctl start k3s
sudo systemctl enable k3s
k3s kubectl get nodes
echo "Kubernetes (K3s) is up and running on Zeus-VM"
'@
$userDataPublicVM = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($UserDataStr))
New-AzVM -ResourceGroupName $resourceGroup -Location $location -Name $vmNamePublic -Size $vmSize -Credential $credential -ImageName "Canonical:UbuntuServer:18.04-LTS:latest" -UserData $userDataPublicVM -Verbose
$UserDataStr = @'
sudo apt-get update
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vault
echo "listener \"tcp\" { address = \"0.0.0.0:8200\" tls_disable = 1 }" | sudo tee /etc/vault.d/config.hcl
echo "storage \"file\" { path = \"/var/lib/vault/data\" }" | sudo tee -a /etc/vault.d/config.hcl
sudo systemctl start vault
sudo systemctl enable vault
export VAULT_ADDR="http://127.0.0.1:8200"
vault operator init -key-shares=1 -key-threshold=1 > /home/azureuser/vault-init.txt
sudo apt-get install -y mongodb
sudo systemctl start mongodb
sudo systemctl enable mongodb
sudo apt-get install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo apt-get install -y postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql
curl -s https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(curl -s https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list)"
sudo apt-get update && sudo apt-get install -y mssql-server
sudo /opt/mssql/bin/mssql-conf setup
sudo systemctl start mssql-server
sudo systemctl enable mssql-server
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
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
sudo mv minio /usr/local/bin
sudo mkdir -p /mnt/data
sudo minio server /mnt/data --console-address ":9001" &
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
Write-Verbose "Creating Private VM (Hades-VM) and installing HashiCorp Vault and other services..."
New-AzVM -ResourceGroupName $resourceGroup -Location $location -Name $vmNamePrivate -Size $vmSizePrivate  -Credential $credential -ImageName "Canonical:UbuntuServer:18.04-LTS:latest" -UserData $userDataPrivateVM -Verbose


# Delete ProdigiesAI
Remove-AzResourceGroup -Name "ProdigiesAI_ResourceGroup" -Force -Verbose
Remove-AzResourceGroup -Name 'NetworkWatcherRG' -Force -Verbose


# Disassociate PublicIP
$resourceGroupName = "Prodigies_ResourceGroup"
$natGatewayName = "Prodigies-NAT"
$publicIpName = "Prodigies-PublicIP"
$natGateway = Get-AzNatGateway -ResourceGroupName $resourceGroupName -Name $natGatewayName
$natGateway.PublicIpAddresses = $natGateway.PublicIpAddresses | Where-Object { $_.Id -ne "/subscriptions/33f8d807-62c2-4c19-9ba0-3d3cef4f5336/resourceGroups/$resourceGroupName/providers/Microsoft.Network/publicIPAddresses/$publicIpName" }
Set-AzNatGateway -NatGateway $natGateway


# Assign Role
New-AzRoleAssignment -ObjectId "user-id" -RoleDefinitionName "Reader" -Scope "/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}"


# Create Storage
$storageAccount = "mystorageaccount"
$resourceGroup = "MyResourceGroup"
$location = "EastUS"
New-AzStorageAccount -ResourceGroupName $resourceGroup -AccountName $storageAccount -Location $location -SkuName "Standard_LRS" -Kind "StorageV2"


# Automation ScheduledTasks
Start-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"


# Deploy ResourceARM
New-AzResourceGroupDeployment -ResourceGroupName "MyResourceGroup" -TemplateFile "C:\Templates\azuredeploy.json"


# Monitor Logs
Get-AzLog -ResourceGroupName "MyResourceGroup"


# Delete NATGateway
$resourceGroupName = "Prodigies_ResourceGroup"
$natGatewayName = "Prodigies-NAT"
Remove-AzNatGateway -ResourceGroupName $resourceGroupName -Name $natGatewayName -Force


# Create VM Linux
$vmName = "MyLinuxVM"
$adminUsername = "azureuser"
$adminPassword = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force
New-AzVM -ResourceGroupName $resourceGroup -Name $vmName -Location $location -VirtualNetworkName $vnetName -SubnetName $subnetName `
    -SecurityGroupName "MyNetworkSecurityGroup" -PublicIpAddressName "MyPublicIP" -OpenPorts 22 `
    -Credential (New-Object System.Management.Automation.PSCredential($adminUsername, $adminPassword)) -Image "UbuntuLTS"


# Setup SQLGeoReplication
New-AzSqlDatabaseSecondary -ResourceGroupName "MyResourceGroup" -ServerName "MyServer" -DatabaseName "MyDatabase" -PartnerServerName "SecondaryServer"


# Scale SQLDatabase
Set-AzSqlDatabase -ResourceGroupName "MyResourceGroup" -ServerName "MySqlServer" -DatabaseName "MyDatabase" -Edition "Standard" -RequestedServiceObjectiveName "S3"


# Assign Permissions
New-AzRoleAssignment -ObjectId "user-id-or-service-principal-id" -RoleDefinitionName "Contributor" -ResourceGroupName "MyResourceGroup"


# Create Kubernates
$resourceGroupName = "Prodigies_ResourceGroup"
$aksClusterName = "Prodigies-Kubernetes-Cluster"
$location = "East US 2"
$nodeCount = 1
$nodeVmSize = "Standard_B2s"
$LinuxProfileAdminUserName = "prodigiesai_root"
$sshPublicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnRnD0YGfN8ZzvrsNl6m3aefLlUyXLH+PvykJ1cN32Hd+7ld9d57zaGnrB4ygXnC9hqLRtBqm/EvCMGW8Trr9F5FO43ii1KAzGMBrys6ZfZluBti7O+mT5naVlslhMAvD6J6wVFrCzZxd+Tm5NO9M9c1iC/8rGSPbf+X0dowbTRZgmtQNA5kNlwqcWjhfRTtQkM6ODysx9i1a2h84yqpxnaNwwZjGy493x3CxRrRBeTnUU52tODfTnqXnRGiwJbJKhlzmOwY8N2raAsAMNSfsAvmhWMg9g8oTShsMgy3V3I4fEOb43azvA63ti2nZKPPh3n/k+T/kXdsW/pefMenu+g6a8S4l/n8n6ve6NRUBPYpjWxS4el0SHaG9fPNPz4cK6N4gKCzmIEnH/cd7uxCDPHvj7mYnEsOl0RqFrovK6WODpFg3glXsbRQgCS1UwUXFjrtd9KIXMxRYewsY9KAgEzGxRr1XLEFH3DVf3XSpAeu+QSZSt72Pk1CGxoqj1+xbqXyH09puMC65eeqwMsLvRw/VfznG7aaSyaXsJBrESan+DXg+nrzi5gutCE4RqvIteOepaCIOcPb1IvugeMOx2JvUjJRfjUqddusKPxlKDX5YvvstPIXKIlssuGKjhapYlMV7+HODa+zSUxiXCAN7BzMdX1YkwDWCDn1O5H5p+kw== obarrientos@oscars-mac-mini.lan"
New-AzAksCluster -ResourceGroupName $resourceGroupName -Name $aksClusterName -Location $location -KubernetesVersion "1.29.7" -NodeCount $nodeCount -NodeVmSize $nodeVmSize -EnableRBAC -LinuxProfileAdminUserName $LinuxProfileAdminUsername -SshKeyValue $sshPublicKey


# Resize VM
$vm = Get-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"
$vm.HardwareProfile.VmSize = "Standard_DS3_v2"
Update-AzVM -ResourceGroupName "MyResourceGroup" -VM $vm


# Create SQLDatabase
$serverName = "MySQLServer"
$adminUsername = "azureadmin"
$adminPassword = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force
$databaseName = "MyDatabase"
New-AzSqlServer -ResourceGroupName $resourceGroup -Location $location -ServerName $serverName -SqlAdministratorCredentials `
    (New-Object System.Management.Automation.PSCredential($adminUsername, $adminPassword))
New-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $serverName -DatabaseName $databaseName -Edition "Basic"


# List VM
Get-AzVM


# Delete KubernatesCluster
$resourceGroupName = "Prodigies_ResourceGroup"
$aksClusterName = "Prodigies-Kubernates-Cluster"
Remove-AzAksCluster -ResourceGroupName $resourceGroupName -Name $aksClusterName


# Generate SSHKey
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_aks


# Create ResourceGroup
New-AzResourceGroup -Name "MyResourceGroup" -Location "EastUS"


# Create PublicIP
$resourceGroupName = "Prodigies_ResourceGroup"
$publicIpName = "Prodigies-PublicIP"
$location = "East US 2"
New-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Name $publicIpName -Location $location -AllocationMethod Static -Sku Standard


# Enable SecurityCenter
Set-AzSecurityContact -Email "admin@domain.com" -Phone "123-456-7890"


# Network Peering
Add-AzVirtualNetworkPeering -Name "VNet1-to-VNet2" -VirtualNetwork $vnet1 -RemoteVirtualNetworkId $vnet2.Id


# Disassociate NATGateway
$vnetName = "Prodigies_ResourceGroup"
$subnetName = "default"
$vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName
$subnet = $vnet.Subnets | Where-Object { $_.Name -eq $subnetName }
$subnet.NatGateway = $null
Set-AzVirtualNetwork -VirtualNetwork $vnet


# Create Alerts
Add-AzMetricAlertRule -ResourceGroupName "MyResourceGroup" -Name "HighCPUMetric" -TargetResourceId "/subscriptions/{sub-id}/resourceGroups/{rg-name}/providers/Microsoft.Compute/virtualMachines/{vm-name}" `
-MetricName "Percentage CPU" -Operator GreaterThan -Threshold 80 -WindowSize 00:05:00


# Enable BackupVM
Set-AzBackupVaultBackupProperties -ResourceGroupName "MyResourceGroup" -VaultName "MyBackupVault" -BackupFrequency "Daily" -RetentionPolicy (New-AzBackupRetentionPolicy)


# Keep Template
Export-AzResourceGroup -ResourceGroupName $resourceGroup -Path "C:\Templates\MyTemplate.json"


# Setup Monitor VMs
Add-AzVMExtension -ResourceGroupName "MyResourceGroup" -VMName "MyVM" -Publisher "Microsoft.Azure.Diagnostics" -ExtensionType "IaaSDiagnostics"


# Create NSG
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName "MyResourceGroup" -Location "EastUS" -Name "MyNSG"
$rule1 = New-AzNetworkSecurityRuleConfig -Name "AllowRDP" -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 `
    -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 3389
$nsg | Add-AzNetworkSecurityRuleConfig -SecurityRule $rule1


# Get Subnet
$resourceGroup = "Prodigies_ResourceGroup"
$location = "EastUS2"
$vnetName = "Prodigies-VNet"
$subnetName = "default"
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup
Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet


# Start a VM
Start-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"

# Stop a VM
Stop-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"

# Restart a VM
Restart-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"



# Create Firewall
$firewallName = "MyFirewall"
$ipConfigName = "MyFirewallIPConfig"
New-AzFirewall -Name $firewallName -ResourceGroupName $resourceGroup -Location $location
$firewall = Get-AzFirewall -Name $firewallName -ResourceGroupName $resourceGroup
New-AzFirewallIpConfiguration -Name $ipConfigName -ResourceGroupName $resourceGroup -Firewall $firewall -SubnetId `
    (Get-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork (Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup)).Id `
    -PublicIpAddressId (Get-AzPublicIpAddress -Name "MyFirewallPublicIP" -ResourceGroupName $resourceGroup).Id


# Create LoadBalancer
$publicIP = New-AzPublicIpAddress -ResourceGroupName "MyResourceGroup" -Name "MyPublicIP" -Location "EastUS" -AllocationMethod Static
$frontendIP = New-AzLoadBalancerFrontendIpConfig -Name "MyFrontendIP" -PublicIpAddress $publicIP
New-AzLoadBalancer -ResourceGroupName "MyResourceGroup" -Name "MyLoadBalancer" -Location "EastUS" -FrontendIpConfiguration $frontendIP


# Delete Cosmos
$resourceGroupName = "Prodigies_ResourceGroup"
$accountName = "prodigies-cosmos"
Remove-AzCosmosDBAccount -ResourceGroupName $resourceGroupName `
                         -Name $accountName

# Delete LogAnalytics
$resourceGroupName = "Prodigies_ResourceGroup"
$workspaceName = "Prodigies-ResourceGroup-EUS2"
Remove-AzOperationalInsightsWorkspace -ResourceGroupName $resourceGroupName -Name $workspaceName -Force

# Create Cosmos
$resourceGroupName = "Prodigies_ResourceGroup"
$location = "East US 2"
$accountName = "prodigies-cosmos"
$kind = "GlobalDocumentDB"  # SQL API
$skuName = "Free"
New-AzCosmosDBAccount -ResourceGroupName $resourceGroupName `
                      -Name $accountName `
                      -Location $location `
                      -ApiKind $kind `
                      -DefaultConsistencyLevel "Session" `
                      -EnableAutomaticFailover `
                      -EnableMultipleWriteLocations `
                      -EnableFreeTier $true `
                      -EnableBurstCapacity $true `
                      -EnableAnalyticalStorage $true `
                      -PublicNetworkAccess "Disabled"


# Create VMScaleSet
New-AzVmss -ResourceGroupName "MyResourceGroup" -Location "EastUS" -VMScaleSetName "MyVmss" -SkuCapacity 2 -VirtualNetworkName "MyVNet" -SubnetName "MySubnet" `
    -PublicIpAddressName "MyPublicIP" -UpgradePolicyMode Automatic


# Attach Disk
$vm = Get-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"
$storageAccount = Get-AzStorageAccount -ResourceGroupName "MyResourceGroup" -Name "mystorageaccount"
$disk = New-AzDiskConfig -AccountType Standard_LRS -DiskSizeGB 128 -CreateOption Empty
Add-AzVMDataDisk -VM $vm -Name "MyDataDisk" -DiskSizeInGB 128 -Lun 0 -Caching ReadWrite -CreateOption Empty
Update-AzVM -ResourceGroupName "MyResourceGroup" -VM $vm


