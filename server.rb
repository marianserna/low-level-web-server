require 'socket'                                    # Require socket from Ruby Standard Library (stdlib)

host = 'localhost'
port = 2000

server = TCPServer.open(host, port)                 # Socket to listen to defined host and port
puts "Server started on #{host}:#{port} ..."        # Output to stdout that server started

loop do                                             # Server runs forever
  client = server.accept                            # Wait for a client to connect. Accept returns a TCPSocket

  lines = []
  while (line = client.gets) && !line.chomp.empty?  # Read the request and collect it until it's empty
    lines << line.chomp
  end
  puts lines                                        # Output the full request to stdout

  header = "HTTP/1.1 200 OK"
  filename = lines[0].gsub(/GET \//, '').gsub(/\ HTTP.*/, '')

  if File.exists?(filename)
    body = File.read(filename)
  else
    # body = "File Not Found\n" # need to indicate end of the string with \n
    body = "#{filename} not found"
  end

  response = [
    header,
    body
  ]

  # time = Time.now.ctime
  # response = "#{header}\r\n\r\n#{time}"       # Output the HTTP header with current time to the client
  client.puts(response.join("\r\n\r\n"))

  client.close                                      # Disconnect from the client
end
