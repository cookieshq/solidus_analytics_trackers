module SpreeAnalyticsTrackers
  class Configuration
    attr_accessor :deface_backend, :deface_frontend

    def initialize
      @deface_backend = true
      @deface_frontend = true
    end
  end
end
