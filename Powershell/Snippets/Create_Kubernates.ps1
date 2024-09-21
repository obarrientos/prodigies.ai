# First Generate SSH Key using  Generate_SSHKey.ps1

# Define variables
$resourceGroupName = "Prodigies_ResourceGroup"
$aksClusterName = "Prodigies-Kubernetes-Cluster"
$location = "East US 2"
$nodeCount = 1
$nodeVmSize = "Standard_B2s"
$LinuxProfileAdminUserName = "prodigiesai_root"
$sshPublicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnRnD0YGfN8ZzvrsNl6m3aefLlUyXLH+PvykJ1cN32Hd+7ld9d57zaGnrB4ygXnC9hqLRtBqm/EvCMGW8Trr9F5FO43ii1KAzGMBrys6ZfZluBti7O+mT5naVlslhMAvD6J6wVFrCzZxd+Tm5NO9M9c1iC/8rGSPbf+X0dowbTRZgmtQNA5kNlwqcWjhfRTtQkM6ODysx9i1a2h84yqpxnaNwwZjGy493x3CxRrRBeTnUU52tODfTnqXnRGiwJbJKhlzmOwY8N2raAsAMNSfsAvmhWMg9g8oTShsMgy3V3I4fEOb43azvA63ti2nZKPPh3n/k+T/kXdsW/pefMenu+g6a8S4l/n8n6ve6NRUBPYpjWxS4el0SHaG9fPNPz4cK6N4gKCzmIEnH/cd7uxCDPHvj7mYnEsOl0RqFrovK6WODpFg3glXsbRQgCS1UwUXFjrtd9KIXMxRYewsY9KAgEzGxRr1XLEFH3DVf3XSpAeu+QSZSt72Pk1CGxoqj1+xbqXyH09puMC65eeqwMsLvRw/VfznG7aaSyaXsJBrESan+DXg+nrzi5gutCE4RqvIteOepaCIOcPb1IvugeMOx2JvUjJRfjUqddusKPxlKDX5YvvstPIXKIlssuGKjhapYlMV7+HODa+zSUxiXCAN7BzMdX1YkwDWCDn1O5H5p+kw== obarrientos@oscars-mac-mini.lan"

# Create the AKS cluster using Managed Identity
New-AzAksCluster -ResourceGroupName $resourceGroupName -Name $aksClusterName -Location $location -KubernetesVersion "1.29.7" -NodeCount $nodeCount -NodeVmSize $nodeVmSize -EnableRBAC -LinuxProfileAdminUserName $LinuxProfileAdminUsername -SshKeyValue $sshPublicKey


