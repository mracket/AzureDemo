$Config = Get-Content -Raw -Path /Users/martin/GitForVLog/AzureDemo/Config.json | ConvertFrom-Json

Foreach ($Subnet in ($($Config.Subnet))) {
    $VNet = Get-AzVirtualNetwork -Name $Subnet.VirtualNetwork
    Add-AzVirtualNetworkSubnetConfig -Name $Subnet.Name -VirtualNetwork $VNet -AddressPrefix $Subnet.AddressPrefix
    $VNet | Set-AzVirtualNetwork
}
