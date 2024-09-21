$vm = Get-AzVM -ResourceGroupName "MyResourceGroup" -Name "MyVM"
$storageAccount = Get-AzStorageAccount -ResourceGroupName "MyResourceGroup" -Name "mystorageaccount"

# Create and attach a new data disk
$disk = New-AzDiskConfig -AccountType Standard_LRS -DiskSizeGB 128 -CreateOption Empty
Add-AzVMDataDisk -VM $vm -Name "MyDataDisk" -DiskSizeInGB 128 -Lun 0 -Caching ReadWrite -CreateOption Empty

# Update the VM
Update-AzVM -ResourceGroupName "MyResourceGroup" -VM $vm
