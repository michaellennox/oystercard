class Journey

  attr_reader :journey_list, :entry_station, :fare

  MINIMUM_CHARGE = 1

  def initialize
    @journey_list = {}
    @fare = 0
  end

  def store_trip(entry, exit)
    @journey_list[entry] = exit
  end

  def set_entrance(station)
    @entry_station = station
  end

  def set_exit(station)
    store_trip(entry_station, station)
    calculate_fare
    set_entrance(nil)
  end

  def in_journey?
    !!entry_station
  end

  def calculate_fare
    in_journey? ? @fare = MINIMUM_CHARGE : @fare = 6
  end

end
