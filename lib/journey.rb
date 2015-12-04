require_relative 'oystercard'

class Journey
  attr_reader :journeys, :index, :index2, :station, :entry_station

  def initialize
    @index2=0
    @index=0
    @journeys={}
    @station=nil
  end

  def make_hash_entry(entry_station)
    @entry_station=entry_station
  @journeys[@index2=@index2+1]=[@entry_station, nil]
  end
  def make_hash(exit_station)

    @journeys[@index=@index+1]=[@entry_station,exit_station]
  end

  def entry_reset
  @entry_station=nil
  end

  def fine1?
  array = @journeys[@index]


    if array[0]==nil
true
else false
end
  end
  def fine2?
    array=@journeys


end
