class BulkDiscountRule
  def initialize(product_code, min_quantity, discounted_price)
    @product_code = product_code
    @min_quantity = min_quantity
    @discounted_price = discounted_price
  end

  def apply(items)
    items
  end
end
