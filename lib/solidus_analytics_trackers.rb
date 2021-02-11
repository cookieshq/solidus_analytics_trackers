require 'solidus_core'
require 'solidus_support'
require 'spree_analytics_trackers/configuration'
require 'spree_analytics_trackers/engine'
require 'spree_analytics_trackers/version'
require 'deface'

module SpreeAnalyticsTrackers
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
