require 'journey'

describe Journey do
  subject(:journey) {described_class.new}
  let(:card) {double(:Oystercard)}
  let(:minimum_fare) {Oystercard::MINIMUM_FARE}

  describe 'defaults' do

    it 'is initially not in a journey' do
      expect(journey.current_journey[:entry_station]).to eq(nil)
    end

    it 'has an empty journey list' do
      expect(journey.journey_history).to eq []
    end

  end

  it 'remembers the station the journey started from' do
    journey.touch_in(:station)
    expect(journey.current_journey[:entry_station]).to eq :station
  end

  context 'touch out' do
    it 'clears entry station on touch out' do
      journey.touch_in(:station)
      journey.touch_out(:station)
      expect(journey.current_journey[:entry_station]).to eq nil
    end
  end

    context 'completed journeys' do
      it 'can recall previous journeys' do
        entry_station = double(:station)
        exit_station = double(:station)
        journey.touch_in(entry_station)
        journey.touch_out(exit_station)
        expect(journey.journey_history).to eq [{entry_station: entry_station, exit_station: exit_station}]
      end
    end
end
