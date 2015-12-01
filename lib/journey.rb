class Journey

  attr_reader :journey_list, :entry_station

  MINIMUM_CHARGE = 1

  def initialize
    @journey_list = {}
  end

  def store_trip(entry, exit)
    @journey_list[entry] = exit
  end

  def set_entrance(station)
    @entry_station = station
  end

  def set_exit(station)
    store_trip(entry_station, station)
    return 6 unless in_journey?
    set_entrance(nil)
    fare
  end

  def in_journey?
    !!entry_station
  end

  def fare
    MINIMUM_CHARGE
  end

end
