# Variables
$vmName = "MyWindowsVM"
$adminUsername = "azureuser"
$adminPassword = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force

# Create a Windows VM
New-AzVM -ResourceGroupName $resourceGroup -Name $vmName -Location $location -VirtualNetworkName $vnetName -SubnetName $subnetName `
    -SecurityGroupName "MyNetworkSecurityGroup" -PublicIpAddressName "MyPublicIP" -OpenPorts 3389 `
    -Credential (New-Object System.Management.Automation.PSCredential($adminUsername, $adminPassword)) -Image "Win2019Datacenter"
