$vm = Get-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"
$vm.HardwareProfile.VmSize = "Standard_DS3_v2"
Update-AzVM -ResourceGroupName "MyResourceGroup" -VM $vm
