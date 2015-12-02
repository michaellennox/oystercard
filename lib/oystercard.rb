#11

class Oystercard
  attr_reader :balance, :entry_station, :journeys
  attr_reader :in_journey

  BALANCE_LIMIT = 90
  BALANCE_MIN = 1
  FARE = 1
  def initialize
    @balance=0
    @in_journey=false
    @journeys={}
  end

  def top_up(amount)
raise "Error £#{BALANCE_LIMIT} limit exceeded" if over_limit?(amount)

      @balance += amount

  end



  def touch_in(entry_station)
    raise  "Error minimum balance to touch in is #{BALANCE_MIN}" if min_limit?

      @in_journey=true
      @entry_station=entry_station




  end
  def touch_out(exit_station)
    @in_journey=false
    fare_pay
    journey_log(exit_station)
    entry_reset

  end
  def in_journey?
    @entry_station
  end
  def pay(amount)
    @balance -= amount

  end

private
def over_limit?(amount)
(@balance + amount) > BALANCE_LIMIT


end
def min_limit?
@balance < BALANCE_MIN
end

def fare_pay
@balance=@balance-FARE
end

def journey_log(exit_station)
@journeys[@entry_station] = exit_station
end

def entry_reset
@entry_station=nil
end
end
