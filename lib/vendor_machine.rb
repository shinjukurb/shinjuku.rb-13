class VendorMachine
  attr_reader :total

  MONEY_LIST = [10, 50, 100, 500, 1000]

  def initialize
    @total = 0
  end

  def insert(money)
    return money unless MONEY_LIST.include? money
    @total += money
    nil
  end

  def refund
    refund_total =  @total
    @total = 0
    refund_total
  end
end
