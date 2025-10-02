require 'bigdecimal'
require 'product'

class BulkDiscountRule
  def initialize(product_code, min_quantity, discounted_price)
    @product_code = product_code
    @min_quantity = min_quantity
    @discounted_price = discounted_price.is_a?(BigDecimal) ? discounted_price : BigDecimal(discounted_price.to_s)
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
    Product.new(item.code, item.name, @discounted_price)
  end
end
