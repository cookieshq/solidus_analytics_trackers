if SpreeAnalyticsTrackers.configuration.use_deface
  Deface::Override.new(
    virtual_path: 'spree/layouts/spree_application',
    name: 'add_segment_page_tracker_to_body',
    insert_bottom: '[data-hook="inside_head"]',
    partial: 'spree/shared/trackers/segment/page_viewed.js'
  )
end
