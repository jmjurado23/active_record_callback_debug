$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'active_record_callbacks_debug/version'

Gem::Specification.new do |s|
  s.name = 'active_record_callbacks_debug'
  s.version = ActiveRecord::CallbacksDebug::VERSION
  s.authors = 'Juan Manuel Jurado'
  s.date = '2020-11-03'
  s.summary = 'Debug callbacks or hook in Active Record'
  s.files = [
    'lib/active_record_callbacks_debug.rb',
    'lib/active_record_callbacks_debug/configuration.rb',
    'lib/active_record_callbacks_debug/version.rb'
  ]
  s.test_files = s.files.grep(%r{^(test|spec)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '~> 2.1'
  s.add_development_dependency 'rspec'
  s.add_dependency 'activesupport', ['>=5.1']
end