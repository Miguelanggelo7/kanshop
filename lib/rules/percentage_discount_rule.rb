class PercentageDiscountRule
  def initialize(product_code, min_quantity, discount_factor)
    @product_code = product_code
    @min_quantity = min_quantity
    @discount_factor = discount_factor
  end

  def apply(items)
    items
  end
end
