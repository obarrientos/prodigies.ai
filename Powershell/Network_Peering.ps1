Add-AzVirtualNetworkPeering -Name "VNet1-to-VNet2" -VirtualNetwork $vnet1 -RemoteVirtualNetworkId $vnet2.Id
