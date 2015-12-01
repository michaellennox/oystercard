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
    !!entry_station
  end

  def touch_in(station)
    fail "Must top up oystercard" if not_working_balance?
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end

  private

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
