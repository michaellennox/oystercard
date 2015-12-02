class Journey

  MINIMUM_FARE = 1
  PENALTY = 6

  attr_reader :journey

  def initialize(start_point)
    @journey = {entry: start_point, exit: nil}
  end

  def in_journey?
    journey[:entry] != nil && journey[:exit] == nil
  end

  def update_exit(station)
    @journey[:exit] = station
  end

  def fare
    MINIMUM_FARE
  end

end
