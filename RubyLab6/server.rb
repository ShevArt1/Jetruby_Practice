require 'socket'
require './App.rb'

server = TCPServer.new('0.0.0.0', 3000)


app = App.new
while connection = server.accept
  request = connection.gets
  method, full_path = request.split(" ")
  path, params = full_path.split('?')
  
  
  status, headers, body =app.call({
    'REQUEST_METHOD' => method,
    'PATH_INFO' => path,
    'QUERY_STRING' =>params
  })
 
  connection.print("HTTP/1.1 #{status}\r\n")
  headers.each { |key, value|  connection.print("#{key}: #{value}\r\n") }
  connection.print "\r\n"
  body.each { |part| connection.print(part) }

  connection.close
end