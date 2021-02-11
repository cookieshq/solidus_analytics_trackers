if SpreeAnalyticsTrackers.configuration.use_deface
  Deface::Override.new(
    virtual_path: 'spree/admin/shared/_settings_sub_menu',
    name: 'add_analytics_to_admin_sidebar',
    insert_bottom: '[data-hook="admin_settings_sub_tabs"]',
    partial: 'spree/admin/shared/analytics_sidebar_menu'
  )
end
