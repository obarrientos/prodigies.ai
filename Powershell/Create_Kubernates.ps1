# Define variables
$resourceGroupName = "Prodigies_ResourceGroup"
$aksClusterName = "Prodigies-Kubernates-Cluster"
$location = "EastUS" # Choose the region where you want the cluster deployed
$nodeCount = 3 # Number of nodes in the cluster
$nodeVmSize = "Standard_DS2_v2" # VM size for the nodes

# Create the AKS cluster
New-AzAksCluster -ResourceGroupName $resourceGroupName `
                 -Name $aksClusterName `
                 -NodeCount $nodeCount `
                 -NodeVmSize $nodeVmSize `
                 -Location $location `
                 -GenerateSshKey `
                 -KubernetesVersion "1.31.0" # Optional: Specify Kubernetes version
