require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey_history, :current_journey
  attr_accessor :journey

  def initialize
    @balance = 0
    @journey_history = []
    @current_journey = {}
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if value + balance > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    fail "Insufficent funds: top up" if balance < MINIMUM_FARE
    start_new_journey
    set_entry(station)
  end

  def touch_out(station)
    journey.set_exit(station)
    @journey_history << current_journey
    @current_journey = {}
    deduct(MINIMUM_FARE)
  end

  def start_new_journey
   @journey = Journey.new
  end

  private

  def set_entry(station)
    @current_journey[:entry_station] = station
  end

  def deduct(value)
    @balance -= value
  end
end
