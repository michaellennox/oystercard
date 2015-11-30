class Oystercard

  attr_reader :balance
  CARD_CAP = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "cap exceeded £#{CARD_CAP}" if over_cap?(amount)
    @balance += amount
  end

  private

  def over_cap?(amount)
    balance + amount > CARD_CAP
  end

end
