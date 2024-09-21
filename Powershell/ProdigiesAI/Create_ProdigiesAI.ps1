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
$ipConfig = New-AzNetworkInterfaceIpConfig -Name $ipConfigName -SubnetId $subnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id 
$nicPublic = New-AzNetworkInterface -ResourceGroupName $resourceGroup -Location $location -Name $nicNamePublic -IpConfiguration $ipConfig -Force

# Configure VM with the NIC
$vmConfigPublic = New-AzVMConfig -VMName $vmNamePublic -VMSize $vmSize
$vmConfigPublic = Add-AzVMNetworkInterface -VM $vmConfigPublic -Id $nicPublic.Id


# 9. Create NIC for Private VM (Hades-VM)
Write-Verbose "Creating NIC for Private VM..."
$ipConfigPrivate = New-AzNetworkInterfaceIpConfig -Name $ipConfigName -SubnetId $subnet.Subnets[0].Id -PrivateIpAddress 10.0.0.5
$nicPrivate = New-AzNetworkInterface -ResourceGroupName $resourceGroup -Location $location -Name $nicNamePrivate -IpConfiguration $ipConfigPrivate -NetworkSecurityGroup $nsgPrivate -Force
# Configure VM with the NIC
$vmConfigPrivate = New-AzVMConfig -VMName $vmNamePrivate -VMSize $vmSize
$vmConfigPrivate = Add-AzVMNetworkInterface -VM $vmConfigPrivate -Id $nicPrivate.Id

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
New-AzVM -ResourceGroupName $resourceGroup -Location $location -Name $vmNamePublic -Size $vmSize --VM $vmConfigPublic -Credential $credential -ImageName "Canonical:UbuntuServer:18.04-LTS:latest" -UserData $userDataPublicVM -Verbose

# Create UserData value
$UserDataStr = @'
#!/bin/bash
sudo apt-get update

# Install Kubernetes (K3s for lightweight Kubernetes)
curl -sfL https://get.k3s.io | sh -
sudo systemctl start k3s
sudo systemctl enable k3s

# Confirm Kubernetes (K3s) installation
k3s kubectl get nodes

# Optionally install any other tools needed for managing Kubernetes
echo "Kubernetes (K3s) is up and running on Hades-VM"
'@;


$userDataPrivateVM = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($UserDataStr))


# 11. Create the Private VM (Hades-VM) and Install HashiCorp Vault, Databases, and Other Services
Write-Verbose "Creating Private VM (Hades-VM) and installing HashiCorp Vault and other services..."
New-AzVM -ResourceGroupName $resourceGroup -Location $location -Name $vmNamePrivate -Size $vmSizePrivate --VM $vmConfigPrivate  -Credential $credential -ImageName "Canonical:UbuntuServer:18.04-LTS:latest" -UserData $userDataPrivateVM -Verbose


# Create the Automation Account
Write-Verbose "Creating  the Automation Account..."
New-AzAutomationAccount -ResourceGroupName $resourceGroup -Location $location -Name "ProdigiesAutomationAccount"


# Import the necessary modules for managing VMs in Azure Automation
Write-Verbose "Import the necessary modules for managing VMs in Azure Automation..."
Import-AzAutomationModule -ResourceGroupName $resourceGroup -AutomationAccountName "ProdigiesAutomationAccount" -Name "Az.Compute"
Import-AzAutomationModule -ResourceGroupName $resourceGroup -AutomationAccountName "ProdigiesAutomationAccount" -Name "Az.Accounts"


# Start VM Rubbooks
Write-Verbose "Creating VM Rubbooks..."
$startVMRunbook = @"
param (
    [string]`$ResourceGroupName = '$resourceGroup',
    [string]`$VMName = 'Zeus-VM'
)
Connect-AzAccount
Start-AzVM -ResourceGroupName `\$ResourceGroupName -Name `\$VMName
"@

New-AzAutomationRunbook -ResourceGroupName $resourceGroup -AutomationAccountName "ProdigiesAutomationAccount" -Name "Start-VM" -Type PowerShell -Description "Runbook to start VMs" -LogProgress $false -LogVerbose $true
Set-AzAutomationRunbookContent -ResourceGroupName $resourceGroup -AutomationAccountName "ProdigiesAutomationAccount" -Name "Start-VM" -ScriptContent $startVMRunbook


$startVMRunbook = @"
param (
    [string]`$ResourceGroupName = '$resourceGroup',
    [string]`$VMName = 'Zeus-VM'
)
Connect-AzAccount
Start-AzVM -ResourceGroupName `\$ResourceGroupName -Name `\$VMName
"@

New-AzAutomationRunbook -ResourceGroupName $resourceGroup -AutomationAccountName "ProdigiesAutomationAccount" -Name "Start-VM" -Type PowerShell -Description "Runbook to start VMs" -LogProgress $false -LogVerbose $true
Set-AzAutomationRunbookContent -ResourceGroupName $resourceGroup -AutomationAccountName "ProdigiesAutomationAccount" -Name "Start-VM" -ScriptContent $startVMRunbook

# Stop VM Rubbooks
$stopVMRunbook = @"
param (
    [string]`$ResourceGroupName = '$resourceGroup',
    [string]`$VMName = 'Zeus-VM'
)
Connect-AzAccount
Stop-AzVM -ResourceGroupName `\$ResourceGroupName -Name `\$VMName -Force
"@

New-AzAutomationRunbook -ResourceGroupName $resourceGroup -AutomationAccountName "ProdigiesAutomationAccount" -Name "Stop-VM" -Type PowerShell -Description "Runbook to stop VMs" -LogProgress $false -LogVerbose $true
Set-AzAutomationRunbookContent -ResourceGroupName $resourceGroup -AutomationAccountName "ProdigiesAutomationAccount" -Name "Stop-VM" -ScriptContent $stopVMRunbook


# Create a schedule to start the VM at 8:00 AM EST
Write-Verbose "Create a schedule to start the VM at 8:00 AM EST..."
$startSchedule = New-AzAutomationSchedule -AutomationAccountName "ProdigiesAutomationAccount" -ResourceGroupName $resourceGroup -Name "Start-VM-Schedule" -StartTime (Get-Date "08:00AM").ToUniversalTime() -DayInterval 1

# Link the schedule to the Start-VM Runbook
Register-AzAutomationScheduledRunbook -AutomationAccountName "ProdigiesAutomationAccount" -ResourceGroupName $resourceGroup -RunbookName "Start-VM" -ScheduleName "Start-VM-Schedule"

# Create a schedule to stop the VM at 6:00 PM EST
Write-Verbose "Create a schedule to stop the VM at 6:00 PM EST"
$stopSchedule = New-AzAutomationSchedule -AutomationAccountName "ProdigiesAutomationAccount" -ResourceGroupName $resourceGroup -Name "Stop-VM-Schedule" -StartTime (Get-Date "06:00PM").ToUniversalTime() -DayInterval 1

# Link the schedule to the Stop-VM Runbook
Register-AzAutomationScheduledRunbook -AutomationAccountName "ProdigiesAutomationAccount" -ResourceGroupName $resourceGroup -RunbookName "Stop-VM" -ScheduleName "Stop-VM-Schedule"
