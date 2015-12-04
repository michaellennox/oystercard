require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :journey

  BALANCE_LIMIT = 90
  BALANCE_MIN = 1
  FARE = 1

  def initialize(journey: Journey.new)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    raise "Error £#{BALANCE_LIMIT} limit exceeded" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise  "Error minimum balance to touch in is #{BALANCE_MIN}" if min_limit?
    pay(journey.fare) if !journey.journey_complete?
    journey.log_entry(entry_station)
  end

  def touch_out(exit_station)
    @journey.make_hash(exit_station)
    fare_pay
    @journey.entry_reset
  end

  def pay(amount)
    @balance -= amount
  end


  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end

  def min_limit?
    @balance < BALANCE_MIN
  end

end
