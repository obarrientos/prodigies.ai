$nsg = New-AzNetworkSecurityGroup -ResourceGroupName "MyResourceGroup" -Location "EastUS" -Name "MyNSG"

# Create an inbound security rule
$rule1 = New-AzNetworkSecurityRuleConfig -Name "AllowRDP" -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 `
    -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange 3389

# Add the rule to the NSG
$nsg | Add-AzNetworkSecurityRuleConfig -SecurityRule $rule1
