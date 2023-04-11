# Import the Azure PowerShell module
Import-Module Az

# Connecting to the Azure Account
Connect-AzAccount

# Get all the subscriptions that authenticated user is part of

$Subscriptions = Get-AzSubscription 

#Loop each subscription

foreach ($subscription in $subscriptions){

#Set the Azure Context by selecting each subscription
Set-AzContext -Subscription $subscription

# Get the Details of the Azure Virtual Machine
$metadata = Get-AzVM

# Extract the relevant information and convert to JSON format
 foreach ($vm in $metadata) {

    #Get the Status of the Azure Virtual Machine
    $status = Get-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName -Status

    #Creating PSCustomObject to store the required data
    $instance_metadata += [PSCustomObject]@{
        SubscriptionName = $subscription.Name
        ResourceGroupName = $vm.ResourceGroupName
        VmName = $vm.Name
        VmResourceId = $vm.Id
        VmLocation = 
        VmType = $vm.HardwareProfile.VmSize
        PrivateIpAddress = $vm.NetworkProfile.NetworkInterfaces[0].IpConfigurations.PrivateIpAddress
        PublicIpAddress = $vm.NetworkProfile.NetworkInterfaces[0].IpConfigurations.PublicIpAddress.Id
        State = $vm.PowerState
        VMStatus = $status.Statuses[1].DisplayStatus
        OsType = $vm.StorageProfile.OsDisk.OsType
    }
}

}
# Output the data and convert to JSON
$instance_metadata | ConvertTo-Json
