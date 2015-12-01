require_relative 'journey'
require_relative 'station'

class Oystercard

  MAXIMUM_CAPACITY = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = MINIMUM_BALANCE

  attr_reader :balance, :journey

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(cash)
    fail "Card at limit £#{MAXIMUM_CAPACITY}" if over_limit?(cash)
    @balance += cash
  end

  def touch_in(station)
    fail "Must top up oystercard" if not_working_balance?
    journey.set_entrance(station)
  end

  def touch_out(station)
    journey.set_exit(station)
    deduct(MINIMUM_CHARGE)
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
