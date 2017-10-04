require_relative 'request'
require_relative 'found'
require_relative 'not_found'
require 'socket'                                    # Require socket from Ruby Standard Library (stdlib)

class Server

  attr_accessor :host, :port, :server

  def initialize(host, port)
    @host = host
    @port = port
  end

  def start
    @server = TCPServer.open(host, port)                # Socket to listen to defined host and port
    puts "Server started on #{host}:#{port} ..."        # Output to stdout that server started
    listen
  end

  private

  def listen
    loop do                                             # Server runs forever
      client = server.accept                            # Wait for a client to connect. Accept returns a TCPSocket
      request = Request.new(client)
      response = if File.exists?(request.filename)
        Found.new(request)
      else
        NotFound.new(request)
      end

      client.puts(response.to_s)

      client.close                                      # Disconnect from the client
    end
  end

end


new_server = Server.new('localhost', 2000)
new_server.start
