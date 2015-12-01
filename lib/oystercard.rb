class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :journey_history, :exit_station

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
    set_entry(station)
  end

  def touch_out(station)
    set_exit(station)
    @journey_history << {entry_station: entry_station, exit_station: exit_station}
    deduct(MINIMUM_FARE)
    clear_entry
  end


  private

  def in_journey?
    !!@entry_station
  end

  def set_exit(station)
    @exit_station = station
  end

  def set_entry(station)
    @entry_station = station
  end

  def clear_entry
    @entry_station = nil
  end

  def deduct(value)
    @balance -= value
  end

end
