class Oystercard
  MAXIMUM_BALANCE = 90
  attr_reader :balance, :in_journey
  alias_method :in_journey?, :in_journey

  def initialize
    @balance = 0
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if value + balance > MAXIMUM_BALANCE
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
