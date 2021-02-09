module Spree
  module TrackersHelper
    def product_for_segment(product, optional = {})
      cache_key = [
        'spree-segment-product',
        I18n.locale,
        current_pricing_options,
        product.cache_key_with_version
      ].compact.join('/')

      product_hash = Rails.cache.fetch(cache_key) do
        {
          product_id: product.id,
          sku: product.sku,
          category: product.taxons.pluck(:name).first,
          name: product.name,
          brand: Spree::Store.default.name,
          price: product.price_for(current_pricing_options).try(:to_d),
          currency: current_pricing_options.currency,
          url: spree.product_url(product)
        }
      end

      product_hash.tap do |hash|
        hash[:image_url] = default_image_for_product_or_variant(product)&.attachment&.url
      end.merge(optional).to_json.html_safe
    end

    def ga_line_item(line_item)
      variant = line_item.variant

      cache_key = [
        'spree-ga-line-item',
        I18n.locale,
        current_pricing_options,
        line_item.cache_key_with_version,
        variant.cache_key_with_version
      ].compact.join('/')

      Rails.cache.fetch(cache_key) do
        product = line_item.product
        {
          id: variant.sku,
          name: variant.name,
          category: product.taxons.pluck(:name).first,
          variant: variant.options_text,
          brand: Spree::Store.default.name,
          quantity: line_item.quantity,
          price: variant.price_for(current_pricing_options).try(:to_d)
        }.to_json.html_safe
      end
    end

    def filtering_param_present?(param)
      params.key?(param) && params.fetch(param).present?
    end

    def any_filtering_params?
      filtering_params.any? { |p| filtering_param_present?(p) }
    end

    def filtering_params_with_values
      params_with_values = {}
      filtering_params.each do |param|
        params_with_values[param] = params.fetch(param) if filtering_param_present?(param)
      end
      params_with_values
    end

    def segment_tracker
      @segment_tracker ||= Spree::Tracker.current(:segment, current_store)
    end

    def segment_enabled?
      segment_tracker.present?
    end

    def ga_tracker
      @ga_tracker ||= Spree::Tracker.current(:google_analytics, current_store)
    end

    def ga_enabled?
      ga_tracker.present?
    end

    def default_image_for_product(product)
      if product.images.any?
        product.images.first
      elsif product.master.images.any?
        product.master.images.first
      elsif product.variant_images.any?
        product.variant_images.first
      end
    end

    def default_image_for_product_or_variant(product_or_variant)
      cache_key = "spree/default-image/#{product_or_variant.cache_key_with_version}"

      Rails.cache.fetch(cache_key) do
        if product_or_variant.is_a?(Spree::Product)
          default_image_for_product(product_or_variant)
        elsif product_or_variant.is_a?(Spree::Variant)
          if product_or_variant.images.any?
            product_or_variant.images.first
          else
            default_image_for_product(product_or_variant.product)
          end
        end
      end
    end
  end
end
