class Journey
  attr_reader :current_journey

  def set_exit(station)
    @current_journey[:exit_station] = station
  end

  def touch_out(station)
    set_exit(station)
    @journey_history << current_journey
    @current_journey = {}
    deduct(MINIMUM_FARE)
  end

end
