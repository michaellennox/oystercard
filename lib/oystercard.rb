require 'journey'
require 'station'

class Oystercard

  MAXIMUM_CAPACITY = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = MINIMUM_BALANCE

  attr_reader :balance, :entry_station, :journey_list

  def initialize
    @balance = 0
    @journey_list = {}
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

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    store_trip(entry_station, station)
    @entry_station = nil
  end

  private

  def store_trip(entry, exit)
    @journey_list[entry] = exit
  end

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
