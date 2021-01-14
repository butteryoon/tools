
$config = $json = Get-Content .\config.json | ConvertFrom-json

$ip = "106.240.249.74"
$api_url = "https://geo.ipify.org/api/v1?" 
$api_key = $config.ipify.api_key

$uri = "$api_url" + "apiKey=$api_key" + "&ipAddress=$ip"

$j = Invoke-WebRequest -Uri $uri
echo $j.content "`n"

