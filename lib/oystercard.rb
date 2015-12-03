require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY_FARE = 6

  attr_reader :balance, :journeylog

  def initialize(journeylog: JourneyLog.new)
    @balance = 0
    @journeylog = journeylog
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if exceeding_max_balance?(value)
    @balance += value
  end

  def touch_in(station)
    fail "Insufficent funds: top up" if below_min_balance?
    charge unless last_journey_complete?
    journeylog.start_journey(station)
  end

  def touch_out(station)
    start_journey_on_exit if last_journey_complete?
    journeylog.end_journey(station) # take this out, still pass arg
    charge # take this out, maybe keep charge?
  end


  private

  def charge
    deduct(journeylog.outstanding_charges)
  end

  def below_min_balance?
    balance < MINIMUM_BALANCE
  end

  def exceeding_max_balance?(value)
    value + balance > MAXIMUM_BALANCE
  end

  def start_journey_on_exit
    journeylog.new_journey
  end

  def last_journey_complete?
    journeylog.last_journey_finished?
  end

  def deduct(value)
    @balance -= value
  end
end
