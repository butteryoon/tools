
$api_url = "https://api.ipify.org?format=json"

$j = Invoke-WebRequest -Uri $api_url 

echo "JSON:`n---" $j.content "`n"

