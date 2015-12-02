
class Station

  attr_reader :zone, :station_name

  def initialize(station_name, zone)
    @zone = zone
    @station_name = station_name
  end
end

# STATIONS = [["liverpool St", 1],["moorgate", 1],["Piccadilly Circus", 1],["Old Street", 1],["Angel", 1],["Benthnal Green", 1] ]

# STATIONS.map do |n|
#   Station.new(n[0].to_sym, n[1])
# end
