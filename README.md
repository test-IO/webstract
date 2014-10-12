# Webstract


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'webstract'
```

```bash
#
# MAC OSX
#
brew install phantomjs

#
# Linux (Ubuntu/Debian)
#
sudo apt-get install libfreetype6 libfreetype6-dev
sudo apt-get install libfontconfig1

# now download from phantomjs website
export PHANTOM_JS="phantomjs-1.9.7-linux-x86_64"
wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2

# create your symlinks
sudo mv $PHANTOM_JS.tar.bz2 /usr/local/share/
cd /usr/local/share/
sudo tar xvjf $PHANTOM_JS.tar.bz2
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/share/phantomjs
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin/phantomjs
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/bin/phantomjs

# now try it
phantomjs --version
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install webstract

## Usage

```ruby

#
# SCREENSHOTS
#

# setup your session
ws = Webstract.screenshot(
  url: "https://www.example.com/admin",
  path: "/tmp/sidekiq.png", # where to save it
  width: 1024,
  height: 768,
  user_agent: :ios, # also (:web, :android)
  accept_language: 'es', # capture the page in a specific language
  basic_auth: {
    username: 'testcloud-admin',
    password: 'admin@testcloud'
  }
)

# now capture the page and save it to the filesystem
ws.capture

#
# FAVICONS
#

fav = Webstract.favicon(url: 'https://www.google.com')
fav.fetch_and_save("/tmp/google.ico")

# or just return raw data
fav.fetch
```

## Debugging

Just set the WEBSTRACT_DEBUG environment variable

```bash
WEBSTRACT_DEBUG=1 ruby my_screenshot_script.rb
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/webstract/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
