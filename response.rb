class Response

  attr_accessor :request

  def initialize(request)
    @request = request
  end

  def to_s
    "#{headers}\r\n\r\n#{body}"
  end
end
