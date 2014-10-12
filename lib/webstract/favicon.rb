require 'faviconduit'

module Webstract
  class Favicon
    attr_accessor :url, :favicon_data

    def initialize(options = {})
      raise(ArgumentError.new("requires url")) unless options.key?(:url)
      @url = options[:url]
    end

    def fetch
      @favicon_data = Faviconduit.get(url).data
    end

    def fetch_and_save(path)
      data = fetch
      File.open(path, 'w') do |f|
        f.write(data)
        f.close
      end
    end

  end
end
