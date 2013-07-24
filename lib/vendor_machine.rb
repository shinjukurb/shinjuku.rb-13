require_relative "drink"

class VendorMachine
  attr_reader :total, :drinks, :sales

  MONEY_LIST = [10, 50, 100, 500, 1000]

  def initialize
    @total = 0
    @sales = 0

    @drinks = [
      Drink.new('コーラ', 120),
      Drink.new('コーラ', 120),
      Drink.new('コーラ', 120),
      Drink.new('コーラ', 120),
      Drink.new('コーラ', 120),
    ]
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
    @drinks.group_by {|drink| drink.name}.each do |key, val|
      buf += "#{key} #{val.first.price}円 #{val.length}個\n"
    end
    buf.chomp
  end



  def available?(drink_name)
    drink = @drinks.find {|d| d.name == drink_name}
    drink && @total >= drink.price
  end

  def stock_of(name)
    @drinks.select{|d| d.name == name }.length
  end

  def sell(drink_name)
    if available? drink_name
      sold_drink = @drinks.delete_at @drinks.find_index{|d| d.name == drink_name}
      @sales += sold_drink.price
      @total -= sold_drink.price
    end
  end

  def stock(drink)
    @drinks << drink
  end

  def list_drinks
    @drinks.map(&:name).uniq
  end

  def available_drinks
    list_drinks.select{|drink_name| available?(drink_name)}
  end
end
