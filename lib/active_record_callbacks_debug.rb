require 'active_support/all'
require 'benchmark'
require 'active_record_callbacks_debug/configuration.rb'

module ActiveRecordCallbacksDebug
  class << self
    attr_accessor :configuration

    def logger
      configuration.logger || Logger.new
    end

    def log(params, bench=nil)
      type = define_type params
      klass = klass params[:target]
      msg = "#{type.upcase}: #{klass} => "

      case type
      when :proc
        msg += "#{params[:over_method]} => proc: #{params[:over_block]}"
      when :val
        msg += "#{params[:over_target].class} > attr: #{params[:over_target].attributes}"
      when :meth
        msg += params[:over_method].to_s
      end

      msg = "#{bench_format(bench)}#{msg}"
      logger.debug msg
      msg
    end

    def define_type(params)
      return :proc if params[:over_block].present?
      return :val if params[:over_method] == 'validate'
      return :meth if params[:over_method].present?
    end

    def klass(klass_source)
      klass_source.class.to_s
    end

    def bench_format(bench)
      return "#{format('%.6f', bench.total)} seg | " if bench.present?

      ''
    end

    def configuration
      @configuration ||= ActiveRecordCallbacksDebug::Configuration.new
    end

    def reset
      @configuration = ActiveRecordCallbacksDebug::Configuration.new
    end

    def configure
      yield(configuration)
    end
  end

  module CallTemplateExtension
    def expand(target, value, block)
      if ::ActiveRecordCallbacksDebug.configuration.active
        result = nil
        params = {
          target: target,
          value: value,
          block: block,
          over_target: @override_target,
          over_method: @method_name,
          over_block: @override_block
        }
        bench = Benchmark.measure { result = super(target, value, block) }
        ::ActiveRecordCallbacksDebug.log(params, bench)
        result
      else
        super(target, value, block)
      end
    end
  end
end

module ActiveSupport
  module Callbacks
    if ::ActiveSupport.gem_version >= ::Gem::Version.new('5.1.0')
      class CallTemplate
        prepend ::ActiveRecordCallbacksDebug::CallTemplateExtension
      end
    else
      Exception.new 'Not work for rails 5.1 <'
    end
  end
end
