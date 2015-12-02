require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey_history, :current_journey
  attr_accessor :journey

  def initialize
    @balance = 0
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
    deduct(MINIMUM_FARE)
  end


  def start_new_journey
    Journey.new
  end

  private


  def deduct(value)
    @balance -= value
  end
end
