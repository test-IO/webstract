require 'open_uri_redirections'
require 'nokogiri'
require 'open-uri'
require "addressable/uri"

module Webstract
  class Favicon
    attr_accessor :url, :data

    def initialize(options = {})
      raise(ArgumentError.new("requires url")) unless options.key?(:url)
      @url = options[:url]
    end

    def fetch
      @data = self.class.get(url).data
    end

    def fetch_and_save(path)
      data = fetch
      File.open(path, 'w') do |f|
        f.write(data)
        f.close
      end
    end

    def self.get(url)

      uri = Addressable::URI.heuristic_parse(url)
      uri = Addressable::URI.encode(uri) # needed for chars with accents in url

      doc = Nokogiri::HTML(open(uri, allow_redirections: :all))

      path = doc.xpath("//link[@rel='shortcut icon' or @rel='icon']/@href").first
      path = path ? path.to_s : '/favicon.ico'

      fav_uri = Addressable::URI.join(uri, path.to_s)

      begin

        stream = open(fav_uri, allow_redirections: :all)

        unless stream.content_type[/^image/]
          raise(Errors::InvalidFavicon, "wrong content_type (#{stream.content_type})")
        end

        data = stream.read

        if data.size == 0
          raise(Errors::InvalidFavicon, "zero data")
        end

        fav = Favicon.new(url: fav_uri.to_s)
        fav.data = data
        return fav

      rescue OpenURI::HTTPError => e
        raise Errors::MissingFavicon if e.to_s[/404/]
        raise # nevermind, reraise the previous exception
      end

    end

  end
end
