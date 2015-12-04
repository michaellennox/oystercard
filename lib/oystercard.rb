require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :journey

  BALANCE_LIMIT = 90
  BALANCE_MIN = 1
  FARE = 1

  def initialize
    @balance=0
    @journey=Journey.new
  end

  def top_up(amount)
    raise "Error £#{BALANCE_LIMIT} limit exceeded" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise  "Error minimum balance to touch in is #{BALANCE_MIN}" if min_limit?
    @entry_station=entry_station
    @journey.make_hash_entry(entry_station)
  end

  def touch_out(exit_station)
    #journey_log(exit_station)
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

  def fare_pay
    if @journey.fine1?
      @balance=@balance-FARE-6
    else
      @balance=@balance-FARE
    end
  end

end
