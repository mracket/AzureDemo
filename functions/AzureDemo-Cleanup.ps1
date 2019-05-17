$Config = Get-Content -Raw -Path /Users/martin/GitForVLog/AzureDemo/Config.json | ConvertFrom-Json

Foreach ($Vnet in ($($Config.VirtualNetwork))) {
    Remove-AzVirtualNetwork -Name $Vnet.Name -ResourceGroupName $Vnet.ResourceGroupName -Force
}

Foreach ($ResourceGroup in ($($Config.ResourceGroup).Name)) {
    Remove-AzResourceGroup -Name $ResourceGroup -Force
}