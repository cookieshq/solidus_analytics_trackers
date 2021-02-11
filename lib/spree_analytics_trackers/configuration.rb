module SpreeAnalyticsTrackers
  class Configuration
    attr_accessor :use_deface

    def initialize
      @use_deface = true
    end
  end
end
