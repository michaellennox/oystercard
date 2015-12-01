class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :in_journey
  alias_method :in_journey?, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if value + balance > MAXIMUM_BALANCE
    @balance += value
  end



  def touch_in
    fail "Insufficent funds: top up" if balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

  private

  def deduct(value)
    @balance -= value
  end
end
