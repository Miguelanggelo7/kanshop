require 'bigdecimal'
require_relative '../decimal_utils'
require_relative '../product'

class BulkDiscountRule
  def initialize(product_code, min_quantity, discounted_price)
    @product_code = product_code
    @min_quantity = min_quantity
    @discounted_price = DecimalUtils.coerce(discounted_price)
  end

  def apply(items)
    return items unless eligible?(items)

    items.map do |item|
      discount_applicable?(item) ? item.with_price(@discounted_price) : item
    end
  end

  private

  def eligible?(items)
    items.count { |item| discount_applicable?(item) } >= @min_quantity
  end

  def discount_applicable?(item)
    item.code == @product_code
  end
end
