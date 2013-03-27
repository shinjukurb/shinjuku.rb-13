class VendorMachine
  attr_accessor :inserted
  def initialize
    @inserted = 0
  end

  def insert(money)
    money_list = [10, 50, 100, 500, 1000]
    if money_list.include?(money)
      @inserted += money
    else
      money
    end
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
