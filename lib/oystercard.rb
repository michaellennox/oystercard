#11

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys
  attr_reader :in_journey

  BALANCE_LIMIT = 90
  BALANCE_MIN = 1
  FARE = 1
def initialize
  @balance=0
  @in_journey=false
  @journeys={}
end

def top_up(x)

  if (@balance + x) > BALANCE_LIMIT
  raise  "Error £#{BALANCE_LIMIT} limit exceeded"
  else
    @balance += x
  end
end

def pay(n)
  @balance=@balance-n

end

def touch_in(entry_station)
  if @balance >= BALANCE_MIN
  @in_journey=true
  @entry_station=entry_station
else
  raise  "Error minimum balance to touch in is #{BALANCE_MIN}"
end
end
def touch_out(exit_station)
@in_journey=false
@balance=@balance-FARE
@entry_station=nil
@exit_station=exit_station
end
def in_journey?
@entry_station
end

end
