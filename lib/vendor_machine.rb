class VendorMachine
  attr_accessor :sum
  def initialize
    @sum = 0
  end

  def insert(money)
    @sum += money
  end
end
