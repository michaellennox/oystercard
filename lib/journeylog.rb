require 'journey'

class JourneyLog

  attr_reader :history, :current_journey

  def initialize(journey: Journey)
    @journey_klass = journey
    @history = []
    @current_journey = @journey_klass.new
  end

  def new_journey
    @current_journey = @journey_klass.new
  end

  def start_journey(station)
    log_journey unless current_journey.complete?
    new_journey
    current_journey.set_entry(station)
  end

  def end_journey(station)
    current_journey.set_exit(station)
    log_journey
  end

  def log_journey
    history << current_journey.current_journey
  end

  def outstanding_charges
    current_journey.fare
  end

  def last_journey_finished?
    current_journey.complete?
  end

end
