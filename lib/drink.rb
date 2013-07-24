class Drink
  attr_accessor :name, :price, :stock

  def initialize(name, price)
    @name = name
    @price = price
  end

  def ==(other)
    name == other.name &&
    price == other.price
  end

end
