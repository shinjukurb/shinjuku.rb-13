class VendorMachine
  attr_accessor :inserted

  MONEY_LIST = [10, 50, 100, 500, 1000]

  def initialize
    @inserted = 0
  end

  def insert(money)
    return money unless MONEY_LIST.include? money
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
