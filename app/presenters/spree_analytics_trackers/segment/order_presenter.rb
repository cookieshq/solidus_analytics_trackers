module SpreeAnalyticsTrackers
  module Segment
    class OrderPresenter < SpreeAnalyticsTrackers::BasePresenter
      private

      def serialize_resource(resource, options = {})
        {
          order_id: resource.number,
          total: resource.total,
          shipping: resource.shipment_total,
          tax: resource.additional_tax_total,
          discount: resource.promo_total,
          coupon: resource.coupon_code,
          currency: resource.currency,
          products: resource.line_items.map { |li| serialize_line_item(li) }
        }
      end

      private

      def serialize_line_item(line_item)
        {
          product_id: line_item.product.id,
          sku: line_item.sku,
          name: line_item.name,
          price: line_item.price,
          quantity: line_item.quantity
        }
      end
    end
  end
end
