if SpreeAnalyticsTrackers.configuration.deface_frontend
  Deface::Override.new(
    virtual_path: 'spree/orders/show',
    name: 'add_google_purchase_to_orders_show',
    insert_after: "#order_summary",
    partial: 'spree/shared/trackers/google_analytics/purchase.js'
  )
end
