$endpoint = New-Object System.Net.IPEndPoint ([System.Net.IPAddress]::any, 58803)
$Listener = New-Object System.Net.Sockets.TcpListener $endpoint
$Listener.Start()
$client = $Listener.AcceptTcpClient()
$stream = $client.GetStream()
$stream.Write([text.Encoding]::Ascii.GetBytes("Hello Telnet World"), 0, 18)

