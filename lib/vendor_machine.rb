class VendorMachine
  attr_accessor :inserted
  def initialize
    @inserted = 0
  end

  def insert(money)
    if money == 10 or money == 50 or 
      money == 100 or 
      money == 500 or  
      money == 1000
      @inserted += money
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
