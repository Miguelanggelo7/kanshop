require 'bigdecimal'
require 'product'

class PercentageDiscountRule
  def initialize(product_code, min_quantity, discount_factor)
    @product_code = product_code
    @min_quantity = min_quantity
    @discount_factor = discount_factor.is_a?(BigDecimal) ? discount_factor : BigDecimal(discount_factor.to_s)
  end

  def apply(items)
    return items unless eligible?(items)

    items.map do |item|
      discount_applicable?(item) ? discounted_item(item) : item
    end
  end

  private

  def eligible?(items)
    items.count { |item| discount_applicable?(item) } >= @min_quantity
  end

  def discount_applicable?(item)
    item.code == @product_code
  end

  def discounted_item(item)
    discounted_price = (item.price * @discount_factor)
    Product.new(item.code, item.name, discounted_price)
  end
end
