require 'bigdecimal'
require_relative '../decimal_utils'
require_relative '../product'

class PercentageDiscountRule
  def initialize(product_code, min_quantity, discount_factor)
    @product_code = product_code
    @min_quantity = min_quantity
    @discount_factor = DecimalUtils.coerce(discount_factor)
  end

  def apply(items)
    return items unless eligible?(items)

    items.map do |item|
      discount_applicable?(item) ? item.with_price(discounted_price_for(item)) : item
    end
  end

  private

  def eligible?(items)
    items.count { |item| discount_applicable?(item) } >= @min_quantity
  end

  def discount_applicable?(item)
    item.code == @product_code
  end
  
  def discounted_price_for(item)
    item.price * @discount_factor
  end
end
