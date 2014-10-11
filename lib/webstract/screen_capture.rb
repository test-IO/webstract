require 'capybara/dsl'

module Webstract
  class ScreenCapture
    include Capybara::DSL

    attr_reader :width, :height, :user_agent, :accept_language, :path

    def initialize(opts = {})
      Webstract::ScreenshotBackend.capybara_setup!
      @width  = opts.fetch(:width, Webstract::ScreenshotBackend.width)
      @height = opts.fetch(:height, Webstract::ScreenshotBackend.height)
      @user_agent = opts.fetch(:user_agent, Webstract::ScreenshotBackend.user_agent)
      @accept_language = opts.fetch(:accept_language, Webstract::ScreenshotBackend.accept_language)

      # Browser settings
      page.driver.resize(@width, @height)
      page.driver.headers = {
        "User-Agent" => @user_agent,
        'Accept-Language' => @accept_language
      }
    end

    def start_session(&block)
      Capybara.reset_sessions!
      Capybara.current_session.instance_eval(&block) if block_given?
      @session_started = true
      self
    end

    # Captures a screenshot of +url+ saving it to +path+.
    def capture(url, path, opts = {})
      begin
        # Default settings
        @width   = opts.fetch(:width, 120)        if opts[:width]
        @height  = opts.fetch(:height, 90)        if opts[:width]

        # Reset session before visiting url
        Capybara.reset_sessions! unless @session_started
        @session_started = false

        # Open page
        visit(url)

        # Timeout
        sleep opts[:timeout] if opts[:timeout]

        # Check response code
        if page.driver.status_code.to_i == 200 || page.driver.status_code.to_i / 100 == 3
          page.driver.save_screenshot(path, :full => true)
        else
          raise Webstract::Error.new("Could not fetch page: #{url.inspect}, error code: #{page.driver.status_code}")
        end
      rescue Capybara::Poltergeist::BrowserError, Capybara::Poltergeist::DeadClient, Capybara::Poltergeist::TimeoutError, Errno::EPIPE => e
        # TODO: Handle Errno::EPIPE and Errno::ECONNRESET
        raise Webstract::Error.new("Capybara error: #{e.message.inspect}")
      end
    end
  end
end
