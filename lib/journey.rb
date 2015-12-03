class Journey

  MINIMUM_FARE = 1

  attr_reader :current_journey

  def initialize
    @current_journey = {}
  end

  def set_entry(station)
    @current_journey[:entry_station] = station
  end

  def set_exit(station)
    @current_journey[:exit_station] = station
  end

  def fare
    MINIMUM_FARE
  end

end
