require_relative 'journey'
require_relative 'station'

class Oystercard

  MAXIMUM_CAPACITY = 90
  MINIMUM_BALANCE = 1

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
    deduct(6) if journey.in_journey?
    journey.set_entrance(station)
  end

  def touch_out(station)
    journey.set_exit(station)
    deduct(journey.fare)
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
