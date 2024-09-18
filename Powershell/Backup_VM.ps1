$backupVault = Get-AzRecoveryServicesVault -ResourceGroupName "MyResourceGroup" -Name "MyBackupVault"
$policy = Get-AzRecoveryServicesBackupProtectionPolicy -VaultId $backupVault.Id -Name "DefaultPolicy"

Enable-AzRecoveryServicesBackupProtection -ResourceGroupName "MyResourceGroup" -Policy $policy -VaultId $backupVault.Id -VMName "MyVM"
