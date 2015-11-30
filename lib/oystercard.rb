class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 90
def initialize
  @balance=0
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

end
def touch_out

end

end
