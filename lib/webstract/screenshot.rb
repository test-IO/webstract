module Webstract
  class Screenshot
    attr_accessor :url, :path, :width, :height, :user_agent, :accept_language
    attr_reader :handle

    def initialize(options = {})
      @handle = Webstract::ScreenCapture.new(options)

      options.each do |k, value|
        setter = "#{k}="
        self.public_send(setter, value) if self.respond_to?(setter)
      end
    end

    def capture
      handle.capture(url, path, width: width, height: height, user_agent: user_agent, accept_language: accept_language)
    end

  end
end
