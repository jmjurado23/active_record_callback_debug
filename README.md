# ActiveRecord::CallbacksDebug

Debug your callbacks in ActiveRecord showing your hooks in a Logger. You can get a list of
all actions (hooks, validations, proc) in your application and so, you can depure your application
callbacks.

## Installation

Add this line to your application's Gemfile:

    gem 'active_record_callbacks_debug', group: [:development, :test]

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_record_callbacks_debug

## Compatibility

Only tested in rails 5.1 > and Mongoid 6.x. It could work in other versions but it has not been tested.

## Usage and configuration

This gem need a configuration file in your rails config/initializer folder

```ruby
ActiveRecord::CalbacksDebug.configure do |config|
  config.active = true # Activate process
  config.logger = ::Rails.logger || Logger.new($stdout) # Rails logger or console
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/active_record_callbacks_debug/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT License
