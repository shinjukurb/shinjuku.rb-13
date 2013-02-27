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

  def refund
    refund_total =  @inserted
    @inserted = 0
    refund_total
  end
end
