require_relative 'oystercard'

class Journey
  attr_reader :journeys, :station, :entry_station

  def initialize
    @journeys={}
    @station=nil
  end

  def log_entry(entry_station)
    @entry_station=entry_station
    @journeys[journeys.size + 1]=[@entry_station, nil]
  end

  def log_exit(exit_station)
    @journeys[journeys.size]=[@entry_station,exit_station]
  end

  def entry_reset
    @entry_station=nil
  end

  def in_journey?

  end

  # def fine1?
  #   array = @journeys[journey.size]
  #   if array[0]==nil
  #     true
  #   else false
  #   end
  # end
  #
  # def fine2?
  #   array=@journeys
  # end

end
