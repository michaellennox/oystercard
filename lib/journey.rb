class Journey

attr_reader :current_journey, :journey_history

def initialize
  @journey_history = []
  @current_journey = {}
end

def touch_in(station)
  set_entry(station)
end

def touch_out(station)
  set_exit(station)
  @journey_history << current_journey
  @current_journey = {}
end

private

def set_entry(station)
  @current_journey[:entry_station] = station
end

def set_exit(station)
  @current_journey[:exit_station] = station
end

end
