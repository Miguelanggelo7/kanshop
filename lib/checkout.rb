# lib/checkout.rb
require 'bigdecimal'

class Checkout
  def initialize(pricing_rules = [])
    @pricing_rules = pricing_rules
    @items = []
  end

  def scan(product)
    @items << product
  end

  def total
    # copy items to avoid modifying the original list
    items_copy = @items.dup

    # apply each pricing rule in sequence
    @pricing_rules.each do |rule|
      items_copy = rule.apply(items_copy)
    end

    # calculate the total price
    total_price = items_copy.map(&:price).reduce(BigDecimal("0")) { |sum, p| sum + p }

    # round to 2 decimal places for currency representation
    total_price.round(2)
  end
end
