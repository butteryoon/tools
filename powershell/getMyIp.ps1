
$ip = "8.8.8.8"
$api_key = "your_api_key"
$api_url = "https://geo.ipify.org/api/v1?"

$uri = "$api_url" + "apiKey=$api_key" + "&ipAddress=$ip"

$j = Invoke-WebRequest -Uri $uri
echo "JSON:`n---" $j.content "`n"

