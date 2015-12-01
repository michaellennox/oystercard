class Oystercard

  MAXIMUM_CAPACITY = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = MINIMUM_BALANCE

  attr_reader :balance, :entry_station

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

  def touch_in(station)
    fail "Must top up oystercard" if not_working_balance?
    @entry_station = station
    @journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @journey = false
  end

  private

  attr_reader :journey

  def deduct(amount)
    @balance -= amount
  end

  def over_limit?(cash)
    balance + cash > MAXIMUM_CAPACITY
  end

  def not_working_balance?
    balance < MINIMUM_BALANCE
  end
end
