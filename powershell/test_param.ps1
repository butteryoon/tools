param (
    [Parameter()]
    [string]
    $ParameterName
)

Write-Host $ParameterName

# date format 
$dateString = Get-Date -UFormat "%Y%m%d-%T%Z"

Write-Host $dateString
