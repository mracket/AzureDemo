$Config = Get-Content -Raw -Path /Users/martin/GitForVLog/AzureDemo/Config.json | ConvertFrom-Json

Foreach ($VM in ($($Config.VM))) {   
    $VNet = Get-AzVirtualNetwork -Name $VM.VNet
    $SubnetID = (Get-AzVirtualNetworkSubnetConfig -Name "AzureDemo-Subnet-Core" -VirtualNetwork $VNet).Id
    $NIC = New-AzNetworkInterface -Name $VM.NIC -ResourceGroupName $VM.ResourceGroupName -Location $Config.Location -SubnetId $SubnetID
    $Credential = New-Object System.Management.Automation.PSCredential ($VM.LocalAdminUser, (ConvertTo-SecureString $VM.LocalAdminSecurePassword -AsPlainText -Force));
    $VirtualMachine = New-AzVMConfig -VMName $VM.Name -VMSize $VM.VMSize
    $VirtualMachine = Set-AzVMOperatingSystem -VM $VirtualMachine -Windows -ComputerName $VM.Name -Credential $Credential -ProvisionVMAgent -EnableAutoUpdate
    $VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $NIC.Id
    $VirtualMachine = Set-AzVMSourceImage -VM $VirtualMachine -PublisherName $VM.PublisherName -Offer $VM.Offer -Skus $VM.SKUs -Version latest
    New-AzVM -ResourceGroupName $VM.ResourceGroupName -Location $Config.Location -VM $VirtualMachine -Verbose   
}