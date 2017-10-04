require_relative 'response'

class Found < Response

  def headers
    success_header = []
    success_header << "HTTP/1.1 200 OK"
    success_header << "Content-Type: text/html" # should reflect the appropriate content type (HTML, CSS, text, etc)
    success_header << "Content-Length: #{body.length}" # should be the actual size of the response body
    success_header << "Connection: close"
    success_header.join("\r\n")
  end

  def body
    File.read(request.filename)
  end
end
