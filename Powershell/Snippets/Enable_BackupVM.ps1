Set-AzBackupVaultBackupProperties -ResourceGroupName "MyResourceGroup" -VaultName "MyBackupVault" -BackupFrequency "Daily" -RetentionPolicy (New-AzBackupRetentionPolicy)
