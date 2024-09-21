# Variables
$resourceGroup = "ProdigiesAI_ResourceGroup"
$location = "EastUS2"
$vnetName = "ProdigiesAI-VNet"
$subnetName = "default"
$publicIpName = "ProdigiesAI-PublicIP"
$nsgNamePublic = "ProdigiesAI-NSG"
$adminUsername = "aiadmin"
$adminPassword = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($adminUsername, $adminPassword)

# VM1 (Public-facing) Details - Call it "ProdigiesAI"
$vmNamePublic = "ProdigiesAI-VM"
$vmSize = "Standard_D2s_v4"
$nicNamePublic = "$vmNamePublic-NIC"
$ipConfigName = "$vmNamePublic-IPConfig"
$vmDiskName = "$vmNamePublic-Disk"
$vmDiskSize = "30"
$vmDiskaccountType = "Standard_LRS"
$tags += @{Servers="Virtual Machine"}

# Enable verbose output for all subsequent commands
$VerbosePreference = "Continue"

# 4. Create Network Security Group for Public VM (ProdigiesAI-VM)
Write-Verbose "Creating Network Security Group for Public-facing VM..."
$nsgPublic = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location -Name $nsgNamePublic -Force


# 5. Add Inbound Rules to Allow SSH and HTTP/HTTPS Traffic on the Public VM (ProdigiesAI-VM)
Write-Verbose "Adding security rules to NSG for Public-facing VM..."
$nsgRuleSSH = New-AzNetworkSecurityRuleConfig -Name "Allow-SSH" -Description "Allow SSH" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 22
$nsgRuleHTTP =New-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Description "Allow HTTP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 80

# Apply the rules to the NSG for Public VM
$nsgPublic.SecurityRules.Add($nsgRuleSSH)
$nsgPublic.SecurityRules.Add($nsgRuleHTTP)
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsgPublic


# Create a virtual machine configuration
$vmConfig = New-AzVMConfig -VMName $vmNamePublic -VMSize $vmSize
$vmConfig = Set-AzVMOSDisk  -VM $vmConfig -Name $vmDiskName -DiskSizeInGB $vmDiskSize -Caching ReadWrite -StorageAccountType $vmDiskaccountType -Linux

# 10. Create the Public-facing VM (ProdigiesAI-VM) with Kubernetes (K3s)
Write-Verbose "Creating Public-facing VM (ProdigiesAI-VM) and installing Kubernetes (K3s)..."

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
echo "Kubernetes (K3s) is up and running on ProdigiesAI-VM"
'@


$userDataPublicVM = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($UserDataStr))
New-AzVM -ResourceGroupName $resourceGroup -Location $location -Name $vmNamePublic -Size $vmSize -VirtualNetworkName $vnetName -SubnetName $subnetName -SecurityGroupName $nsgNamePublic -PublicIpAddressName $publicIpName -Credential $credential -ImageName "Canonical:UbuntuServer:18.04-LTS:latest" -UserData $userDataPublicVM -Verbose

# Set the tag
Set-AzResource -Name $vmNamePublic -ResourceGroupName $resourceGroup -ResourceType "Microsoft.Compute/VirtualMachines" -Tag $tags -Force

# Stop the VM
Stop-AzVM -Name $vmNamePublic -ResourceGroupName $resourceGroup -Force

# Write completion message
Write-Host "Azure VM creation completed" -foreground green

# Clear variables
Remove-Variable * -ErrorAction SilentlyContinue

