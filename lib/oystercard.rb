class Oystercard
  attr_reader :balance
  attr_reader :in_journey
  BALANCE_LIMIT = 90
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
@in_journey=true
end
def touch_out
@in_journey=false
end
def in_journey?
@in_journey
end

end
