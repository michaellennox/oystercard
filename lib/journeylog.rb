require 'journey'

class JourneyLog

  attr_reader :history

  def initialize(journey: Journey)
    @journey_klass = journey
    @history = []
  end

end
