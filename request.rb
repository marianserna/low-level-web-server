class Request

  def initialize(client)
    @lines = []
    while (line = client.gets) && !line.chomp.empty?  # Read the request and collect it until it's empty
      @lines << line.chomp
    end
    puts @lines                                        # Output the full request to stdout
  end

  def filename
    filename = @lines[0].gsub(/GET \//, '').gsub(/\ HTTP.*/, '')
  end
end
