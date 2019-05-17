$Config = Get-Content -Raw -Path /Users/martin/GitForVLog/AzureDemo/Config.json | ConvertFrom-Json
Foreach ($NSG in ($($Config.NetworkSecurityGroup))){
    Remove-AzNetworkSecurityGroup -Name $NSG.Name -ResourceGroupName $NSG.ResourceGroupName -Force
}
Foreach ($Vnet in ($($Config.VirtualNetwork))) {
    Remove-AzVirtualNetwork -Name $Vnet.Name -ResourceGroupName $Vnet.ResourceGroupName -Force
}
Foreach ($ResourceGroup in ($($Config.ResourceGroup).Name)) {
    Remove-AzResourceGroup -Name $ResourceGroup -Force
}
Try {
    Get-AzResourceGroup -Name NetworkWatcherRG -ErrorAction Stop | Out-Null
    Remove-AzResourceGroup -Name NetworkWatcherRG -Force
} Catch {
    Write-Verbose "Resourcegroup NetworkWatcherRG was not found"
}