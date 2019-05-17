$Config = Get-Content -Raw -Path /Users/martin/GitForVLog/AzureDemo/Config.json | ConvertFrom-Json

Foreach ($ResourceGroup in ($($Config.ResourceGroup).Name)) {
    Remove-AzResourceGroup -Name $ResourceGroup -Force
}