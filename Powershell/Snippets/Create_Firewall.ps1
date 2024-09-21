# Variables
$firewallName = "MyFirewall"
$ipConfigName = "MyFirewallIPConfig"

# Create the Firewall
New-AzFirewall -Name $firewallName -ResourceGroupName $resourceGroup -Location $location

# Create Firewall IP Config
$firewall = Get-AzFirewall -Name $firewallName -ResourceGroupName $resourceGroup
New-AzFirewallIpConfiguration -Name $ipConfigName -ResourceGroupName $resourceGroup -Firewall $firewall -SubnetId `
    (Get-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork (Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup)).Id `
    -PublicIpAddressId (Get-AzPublicIpAddress -Name "MyFirewallPublicIP" -ResourceGroupName $resourceGroup).Id
