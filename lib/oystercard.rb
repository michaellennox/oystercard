require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if value + balance > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    fail "Insufficent funds: top up" if balance < MINIMUM_FARE
    @journey = start_new_journey
    @journey.touch_in(station)
  end

  def touch_out(station)
    @journey.touch_out(station)
    @journey_history << journey.current_journey
    deduct(MINIMUM_FARE)
  end


  private

  def start_new_journey
    Journey.new
  end

  def deduct(value)
    @balance -= value
  end
end
