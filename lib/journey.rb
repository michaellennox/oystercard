class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

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
    journey_complete? ? fare = MINIMUM_FARE : fare = PENALTY_FARE
    fill_journey
    fare
  end

  def fill_journey
    current_journey[:entry_station] = :failure if current_journey[:entry_station].nil?
    current_journey[:exit_station] = :failure if current_journey[:exit_station].nil?
  end

  def journey_complete?
    !current_journey[:entry_station].nil? && !current_journey[:exit_station].nil? || current_journey[:entry_station].nil? && current_journey[:exit_station].nil?
  end

end
