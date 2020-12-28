from http.server import HTTPServer, SimpleHTTPRequestHandler
import ssl


httpd = HTTPServer(('', 54443), SimpleHTTPRequestHandler) 

httpd.socket = ssl.wrap_socket (httpd.socket, keyfile='/home/butteryoon/.ssl/privkey.pem', certfile='/home/butteryoon/.ssl/fullchain.pem', server_side=True)

httpd.serve_forever()
