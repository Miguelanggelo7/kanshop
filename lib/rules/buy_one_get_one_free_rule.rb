class BuyOneGetOneFreeRule
  def initialize(product_code)
    @product_code = product_code
  end

  def apply(items)
    items
  end
end
