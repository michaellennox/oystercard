class Oystercard

  MAXIMUM_CAPACITY = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(cash)
    fail "Card at limit £#{MAXIMUM_CAPACITY}" if over_limit?(cash)
    @balance += cash
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    journey
  end

  def touch_in
    @journey = true
  end

  def touch_out
    @journey = false
  end

  private

  attr_reader :journey

  def over_limit?(cash)
    balance + cash > MAXIMUM_CAPACITY
  end
end
