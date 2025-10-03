require 'bigdecimal'
require_relative 'decimal_utils'

class Product
  attr_reader :code, :name, :price

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = DecimalUtils.coerce(price)
  end

  def with_price(new_price)
    self.class.new(code, name, new_price)
  end
end
