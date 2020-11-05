# ActiveRecordCallbacksDebug

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

This gem need a configuration file in your rails config/environments/development.rb or in config/environments/test.rb folder. This method will cause performance issues in production environment.

```ruby
ActiveRecordCalbacksDebug.configure do |config|
  config.active = true # Activate process
  config.logger = ::Rails.logger || Logger.new($stdout) # Rails logger or console
end
```

## Example
Once you active the extension, you will receive a log like the next one:

```ruby
pry(main)> Mymodel.last.save
D, [2020-11-04T19:50:26.356834 #65826] DEBUG -- : 0.000022 seg | PROC: Mymodel => instance_exec => proc: #<Proc:0x00007fe602c375e0 /home/jmjurado23/.asdf/installs/ruby/2.7.1/lib/ruby/gems/2.7.0/gems/mongoid-normalize-strings-0.1.3/lib/mongoid-normalize-strings/normalize.rb:37>
D, [2020-11-04T19:50:26.357303 #65826] DEBUG -- : 0.000017 seg | VAL: Mymodel => Mongoid::Validatable::PresenceValidator > attr: ["name"]
D, [2020-11-04T19:50:26.357664 #65826] DEBUG -- : 0.000018 seg | VAL: Mymodel => Mongoid::Validatable::AssociatedValidator > attr: [:other_models]
D, [2020-11-04T19:50:26.370173 #65826] DEBUG -- : 0.000016 seg | METH: Mymodel => denormalize_info

```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/active_record_callbacks_debug/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT License
