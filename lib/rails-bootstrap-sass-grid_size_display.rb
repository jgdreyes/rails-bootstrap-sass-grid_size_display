require "grid_size_display/engine"

module GridSizeDisplay

  def self.config
    @config ||= ::GridSizeDisplay::Config.new
  end

  def self.configure(&_block)
    yield(config) if block_given?
  end

  class Config
    attr_accessor :enabled

    def initialize
      @enabled = Rails.env.development?
    end

    def enabled?
      @enabled
    end
  end
end
