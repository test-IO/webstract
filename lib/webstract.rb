module Webstract

  autoload :Errors, 'webstract/errors'
  autoload :ScreenCapture, 'webstract/screen_capture'
  autoload :ScreenshotBackend, 'webstract/screenshot_backend'
  autoload :Screenshot, 'webstract/screenshot'
  autoload :Favicon,    'webstract/favicon'

  def self.screenshot(options = {})
    Webstract::Screenshot.new(options)
  end

  def self.favicon(options = {})
    Webstract::Favicon.new(options)
  end

end
