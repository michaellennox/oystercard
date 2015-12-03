require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY_FARE = 6

  attr_reader :balance, :journey, :journey_history, :journey_klass

  def initialize(journey: Journey)
    @balance = 0
    @journey_history = []
    @journey_klass = journey
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if exceeding_max_balance?(value)
    @balance += value
  end

  def touch_in(station)
    fail "Insufficent funds: top up" if below_min_balance?
    charge_and_log if journey_exists?
    start_new_journey
    journey.set_entry(station)
  end

  def touch_out(station)
    start_new_journey unless journey_exists?
    journey.set_exit(station)
    charge_and_log
    @journey = nil
  end


  private

  def charge_and_log
    deduct(journey.fare)
    journey_history << journey.current_journey
  end

  def journey_exists?
    !journey.nil?
  end

  def below_min_balance?
    balance < MINIMUM_BALANCE
  end

  def exceeding_max_balance?(value)
    value + balance > MAXIMUM_BALANCE
  end

  def start_new_journey
    @journey = journey_klass.new
  end

  def deduct(value)
    @balance -= value
  end
end
