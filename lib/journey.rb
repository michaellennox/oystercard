class Journey

  attr_reader :journey_list
  
  def initialize
    @journey_list = {}
  end

  def store_trip(entry, exit)
    @journey_list[entry] = exit
  end

end
