$vms = Get-AzVM -ResourceGroupName "MyResourceGroup"
foreach ($vm in $vms) {
    if ($vm.Statuses[1].Code -eq "PowerState/deallocated") {
        Remove-AzVM -ResourceGroupName "MyResourceGroup" -Name $vm.Name
    }
}
