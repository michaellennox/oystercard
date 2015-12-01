class Journey

  attr_reader :journey_list, :entry_station

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
    set_entrance(nil)
  end

  def in_journey?
    !!entry_station
  end

end
