

class Oystercard

  DEFAULT_BALANCE = 0

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    @balance += amount
  end

end
