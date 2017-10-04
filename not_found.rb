class NotFound < Response

  def headers
    not_found_header = []
    not_found_header << "HTTP/1.1 404 Not Found"
    not_found_header << "Content-Type: text/plain" # is always text/plain
    not_found_header << "Content-Length: #{body.length}" # should the actual size of the response body
    not_found_header << "Connection: close"
    not_found_header.join("\r\n")
  end

  def body
    "#{request.filename} not found"
  end
end
