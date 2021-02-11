if SpreeAnalyticsTrackers.configuration.use_deface
  Deface::Override.new(
    virtual_path: 'spree/layouts/spree_application',
    name: 'add_google_analytics_initializer_to_spree_application',
    insert_bottom: '[data-hook="inside_head"]',
    partial: 'spree/shared/trackers/google_analytics/initializer.js'
  )
end
