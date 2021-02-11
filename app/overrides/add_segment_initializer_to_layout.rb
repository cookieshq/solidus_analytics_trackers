if SpreeAnalyticsTrackers.configuration.use_deface
  Deface::Override.new(
    virtual_path: 'spree/layouts/spree_application',
    name: 'add_segment_initializer_to_head',
    insert_bottom: '[data-hook="inside_head"]',
    partial: 'spree/shared/trackers/segment/initializer.js'
  )
end
