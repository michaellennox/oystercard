
class Oystercard

  attr_reader :balance, :journeys, :current_journey

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journeys = []
  end

  def touch_in(station)
    fail "Your balance is too low. Please top up!" if balance_too_low?
    penalize_on_entry if journey_running?
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    journey_running? ? message_journey_updates(station) : penalize_on_exit(station)
  end

  def update_history
    @journeys << current_journey.journey
    @current_journey = nil
  end

  def top_up(amount)
    raise "card limit of #{MAXIMUM_BALANCE} exceeded" if limit_exceeded?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end


  private

  def penalize_on_entry
    deduct(PENALTY_FARE)
    @journeys << current_journey.journey
  end

  def penalize_on_exit(station)
    deduct(PENALTY_FARE)
    @journeys << {entry: nil, exit: station}
  end

  def journey_running?
    !current_journey.nil?
  end

  def message_journey_updates(station)
    current_journey.update_exit(station)
    deduct(current_journey.fare)
    update_history
  end

  def limit_exceeded?(amount)
    amount + balance > MAXIMUM_BALANCE
  end

  def balance_too_low?
    balance < MINIMUM_FARE
  end

end
