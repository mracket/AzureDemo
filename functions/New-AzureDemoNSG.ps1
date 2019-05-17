$Config = Get-Content -Raw -Path /Users/martin/GitForVLog/AzureDemo/Config.json | ConvertFrom-Json

Foreach ($NSG in ($($Config.NetworkSecurityGroup))) {
    New-AzNetworkSecurityGroup -Name $NSG.NAme -ResourceGroupName $NSG.ResourceGroupName -Location $Config.Location
}
Foreach ($NSGRule in ($($Config.NetworkSecurityGroupRules))){
    $NSGRuleParam = @{
        Name = $NSGRule.Name 
        Description = $NSGRule.Description 
        Access = $NSGRule.Access
        Protocol = $NSGRule.Protocol 
        Direction = $NSGRule.Direction
        Priority = $NSGRule.Priority 
        SourceAddressPrefix = $NSGRule.SourceAddressPrefix
        SourcePortRange = $NSGRule.SourceAddressPortRange
        DestinationAddressPrefix = $NSGRule.DestinationAddressPrefix
        DestinationPortRange = $NSGRule.DestinationPortRange
    }    
    Get-AzNetworkSecurityGroup -Name $NSGRule.NetworkSecurityGroup |
    Add-AzNetworkSecurityRuleConfig @NSGRuleParam |   
    Set-AzNetworkSecurityGroup 
}
