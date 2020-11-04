module ActiveRecordCallbacksDebug
  class Configuration
    attr_accessor :active, :logger

    def initialize
      @active = false
      @logger = Logger.new($stdout)
    end
  end
end
