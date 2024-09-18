# Variables
$vmName = "MyLinuxVM"
$adminUsername = "azureuser"
$adminPassword = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force

# Create a Linux VM
New-AzVM -ResourceGroupName $resourceGroup -Name $vmName -Location $location -VirtualNetworkName $vnetName -SubnetName $subnetName `
    -SecurityGroupName "MyNetworkSecurityGroup" -PublicIpAddressName "MyPublicIP" -OpenPorts 22 `
    -Credential (New-Object System.Management.Automation.PSCredential($adminUsername, $adminPassword)) -Image "UbuntuLTS"
