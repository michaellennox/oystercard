class Oystercard

  attr_reader :balance
  CARD_CAP = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Cap exceeded £#{CARD_CAP}" if exceed_cap?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private

  def exceed_cap?(amount)
    balance + amount > CARD_CAP
  end

end
