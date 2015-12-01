class Oystercard
  attr_reader :balance
  attr_reader :in_journey
  BALANCE_LIMIT = 90
  BALANCE_MIN = 1
  FARE = 1
def initialize
  @balance=0
  @in_journey=false
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

def touch_in
  if @balance >= BALANCE_MIN
@in_journey=true
else
  raise  "Error minimum balance to touch in is #{BALANCE_MIN}"
end
end
def touch_out
@in_journey=false
@balance=@balance-FARE
end
def in_journey?
@in_journey
end

end
