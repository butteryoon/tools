from http.server import HTTPServer, BaseHTTPRequestHandler
import ssl


httpd = HTTPServer(('', 54443), BaseHTTPRequestHandler) 

httpd.socket = ssl.wrap_socket (httpd.socket, keyfile='/home/lcsapp/pkg/letsencrypt/www/privkey.pem', certfile='/home/lcsapp/pkg/letsencrypt/www/cert.pem', server_side=True)

httpd.serve_forever()
