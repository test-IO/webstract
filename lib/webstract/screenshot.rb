require 'webshot'

module Webstract
  class Screenshot
    attr_accessor :url, :path, :width, :height, :quality
    attr_reader :handle

    def initialize(options = {})
      @handle = Webshot::Screenshot.instance

      options.each do |k, value|
        setter = "#{k}="
        self.public_send(setter, value) if self.respond_to?(setter)
      end

      @quality = 85 unless self.quality
    end

    def capture
      handle.capture(url, path, width: width, height: height, quality: quality)
    end

  end
end
