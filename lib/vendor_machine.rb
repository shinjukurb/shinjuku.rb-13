require_relative "drink"

class VendorMachine
  attr_reader :total

  MONEY_LIST = [10, 50, 100, 500, 1000]
  DRINKS = [
    Drink.new('コーラ', 120),
    Drink.new('コーラ', 120),
    Drink.new('コーラ', 120),
    Drink.new('コーラ', 120),
    Drink.new('コーラ', 120),
    Drink.new('ドクペ', 120),
  ]

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

  def show_drinks
    buf = ""
    DRINKS.group_by {|drink| drink.name}.each do |key, val|
      buf += "#{key} #{val.first.price}円 #{val.length}個\n"
    end
    buf.chomp
  end

  def available?(drink_name)
    drink = DRINKS.find {|d| d.name == drink_name}
    drink && @total >= drink.price
  end
end
