require 'bigdecimal'
require 'product'

class BuyOneGetOneFreeRule
  def initialize(product_code)
    @product_code = product_code
  end

  def apply(items)
    result = []
    counter = 0

    items.each do |item|
      if item.code == @product_code
        counter += 1
        # Cada segunda unidad es gratis
        if counter.even?
          # Creamos una copia del producto pero con precio 0
          result << Product.new(item.code, item.name, BigDecimal("0"))
        else
          result << item
        end
      else
        result << item
      end
    end

    result
  end
end
