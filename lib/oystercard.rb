class Oystercard

  MAXIMUM_CAPACITY = 90
  MINIMUM_BALANCE = 1

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
    fail "Must top up oystercard" if not_working_balance?
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

  def not_working_balance?
    balance < MINIMUM_BALANCE 
  end
end
