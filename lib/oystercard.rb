
class Oystercard

  attr_reader :balance, :journeys, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
    @journey = {entry: nil, exit: nil}
  end

  def in_journey?
    journey[:entry] != nil && journey[:exit] == nil
  end

  def touch_in(station)
    fail "Your balance is too low. Please top up!" if balance_too_low?
    update_entry(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    update_exit(station)
    update_history
  end

  def update_entry(station)
    @journey[:entry] = station
  end

  def update_exit(station)
    @journey[:exit] = station
  end

  def update_history
    @journeys << journey
    @journey = {entry: nil, exit: nil}
  end

  def top_up(amount)
    raise "card limit of #{MAXIMUM_BALANCE} exceeded" if limit_exceeded?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end


  private

  def limit_exceeded?(amount)
    amount + balance > MAXIMUM_BALANCE
  end

  def balance_too_low?
    balance < MINIMUM_FARE
  end

end
