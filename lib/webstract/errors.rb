module Webstract
  module Errors

    class PathNotWritableError < StandardError; ;end

    # raised whenever a webpage capture fails due to browser/connection client errors
    class CaptureError < StandardError; ;end

    # raised when the target page could not be reached
    # but due to server errors like 404, or 500.
    class PageError < StandardError; ;end
  end
end
