$gwipconfig = New-AzVirtualNetworkGatewayIpConfig -Name "MyGatewayIPConfig" -SubnetId $subnet.Id -PublicIpAddressId $publicip.Id

New-AzVirtualNetworkGateway -ResourceGroupName "MyResourceGroup" -Name "MyVNetGateway" -Location "EastUS" -IpConfigurations $gwipconfig -GatewayType Vpn -VpnType RouteBased
