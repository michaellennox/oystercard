class Station
  attr_reader :zone, :name

  def initialize (station, zone)
    @zone = zone
    @name = station
  end

end
