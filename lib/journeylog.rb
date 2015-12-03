require 'journey'

class JourneyLog

  attr_reader :history, :current_journey

  def initialize(journey: Journey)
    @journey_klass = journey
    @history = []
  end

  def new_journey
    @current_journey = @journey_klass.new
  end

  def start_journey(station)
    new_journey
    current_journey.set_entry(station)
  end
end
