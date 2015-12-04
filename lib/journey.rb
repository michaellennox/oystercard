require_relative 'oystercard'

class Journey
  attr_reader :journeys, :entry_station
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @journeys={}
  end

  def log_entry(entry_station)
    @entry_station=entry_station
    @journeys[journeys.size + 1]=[@entry_station, nil]
  end

  def log_exit(exit_station)
    @journeys[journeys.size]=[@entry_station,exit_station]
    @entry_station = nil
  end

  def entry_reset
    @entry_station=nil
  end

  def journey_complete?
    return true if @journeys.empty?
    !@journeys[journeys.size].include?(nil)
  end

  def fare
    journey_complete? ? MIN_FARE : PENALTY_FARE
  end


end
