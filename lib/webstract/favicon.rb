require 'faviconduit'

=begin

usage:

favicon = Webstract::Favicon.new(url: 'https://example.com')
favicon.fetch

=end

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

  end
end
