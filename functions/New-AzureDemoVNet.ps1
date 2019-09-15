$Config = Get-Content -Raw -Path /Users/martin/GitForVLog/AzureDemo/Config.json | ConvertFrom-Json

Foreach ($VNet in ($($Config.VirtualNetwork))) {
    New-AzVirtualNetwork -Name $VNet.Name -ResourceGroupName $VNet.ResourceGroupName -Location $Config.Location    -AddressPrefix $VNet.AddressPrefix 
}