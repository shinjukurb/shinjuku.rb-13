class VendorMachine
  attr_accessor :inserted
  def initialize
    @inserted = 0
  end

  def insert(money)
    @inserted += money
  end

  def total
    @inserted
  end
end
