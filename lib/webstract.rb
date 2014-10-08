module Webstract

  autoload :Screenshot, 'webstract/screenshot'
  autoload :Favicon, 'webstract/favicon'

  def self.screenshot(options = {})
    Webstract::Screenshot.new(options)
  end

  def self.favicon(options = {})
    Webstract::Favicon.new(options)
  end

end
