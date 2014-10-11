require "capybara/dsl"
require "capybara/poltergeist"
require "active_support"
require "active_support/core_ext"

module Webstract
  module ScreenshotBackend

    USER_AGENTS = {
      web: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31',
      android: 'Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 4 Build/JOP40D) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Safari/535.19',
      ios: 'Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3'
    }

    ## Browser settings
    # Width
    mattr_accessor :width
    @@width = 1024

    # Height
    mattr_accessor :height
    @@height = 768

    mattr_accessor :accept_language
    @@accept_language = 'en-us,en;q=0.5'


    # User agent
    class << self

      def user_agent
        @user_agent ||= USER_AGENT[:web]
      end
      def user_agent=(ua)
        agent_string = USER_AGENT[ua]
        raise(ArgumentError.new('must be one of #{USER_AGENTS.inspect}')) unless agent_string
        @user_agent = agent_string
      end

    end

    # Customize settings
    def self.setup
      yield(self)
    end

    # Capibara setup
    def self.capybara_setup!
      # By default Capybara will try to boot a rack application
      # automatically. You might want to switch off Capybara's
      # rack server if you are running against a remote application
      Capybara.run_server = false
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, {
          # Raise JavaScript errors to Ruby
          js_errors: false,
          # Additional command line options for PhantomJS
          phantomjs_options: ['--ignore-ssl-errors=yes'],
        })
      end
      Capybara.current_driver = :poltergeist
    end
  end
end
