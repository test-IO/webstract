module Webstract
  class Screenshot
    attr_accessor :url, :width, :height, :user_agent, :accept_language, :basic_auth
    attr_reader :handle, :path

    def initialize(options = {})
      @handle = Webstract::ScreenCapture.new(options)

      options.each do |k, value|
        setter = "#{k}="
        self.public_send(setter, value) if self.respond_to?(setter)
      end
      path = options[:path] || raise(ArgumentError.new('path required'))
      @basic_auth ||= {}

      raise(ArgumentError.new("basic_auth credentials must be a Hash: got #{@basic_auth.inspect}")) unless @basic_auth.is_a?(Hash)
    end

    def path=(path)
      dir = File.dirname(path)
      raise(Webstract::Errors::PathNotWritableError.new('path must be writable.')) unless File.writable?(dir)
      @path = path
    end

    def username=(username)
      @basic_auth[:username] = username
    end

    def password=(password)
      @basic_auth[:password] = password
    end

    def capture
      handle.capture(url, path,
        width: width,
        height: height,
        user_agent: user_agent,
        accept_language: accept_language,
        basic_auth: basic_auth
      )
    end

  end
end
