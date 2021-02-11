if SpreeAnalyticsTrackers.configuration.use_deface
  Deface::Override.new(
    virtual_path: 'spree/products/index',
    name: 'add_products_searched_to_products_list',
    insert_bottom: '[data-hook="search_results"]',
    partial: 'spree/shared/trackers/segment/products_searched.js'
  )
end
