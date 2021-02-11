if SpreeAnalyticsTrackers.configuration.deface_frontend
  Deface::Override.new(
    virtual_path: 'spree/layouts/spree_application',
    name: 'add_segment_page_tracker_to_head',
    insert_bottom: '[data-hook="inside_head"]',
    partial: 'spree/shared/trackers/segment/page_viewed.js'
  )
end
