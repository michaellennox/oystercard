
class Oystercard

  attr_reader :balance, :journeys, :current_journey

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def touch_in(station)
    fail "Your balance is too low. Please top up!" if balance_too_low?
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    current_journey.update_exit(station)
    update_history
    deduct(current_journey.fare)
  end

  def update_history
    @journeys << current_journey.journey
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
