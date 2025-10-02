require 'bigdecimal'
require 'product'

class BuyOneGetOneFreeRule
  def initialize(product_code)
    @product_code = product_code
  end

  def apply(items)
    eligible_items, other_items = items.partition { |item| applies_to?(item) }
    adjusted_items = apply_bogof(eligible_items)
    adjusted_items + other_items
  end

  private

  def applies_to?(item)
    item.code == @product_code
  end

  def apply_bogof(items)
    items.each_with_index.map do |item, index|
      free_item?(index) ? Product.new(item.code, item.name, BigDecimal("0")) : item
    end
  end

  def free_item?(index)
    (index + 1).even?
  end
end
