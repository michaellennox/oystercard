require 'journey'

describe Journey do
  subject(:journey) {described_class.new}
  let(:card) {double(:oystercard)}
  let(:station1) {double(:station)}
  let(:station2) {double(:station)}

  describe '#initialize' do
    it 'is initially not in a journey' do
      expect(journey.current_journey[:entry_station]).to eq(nil)
    end
  end

  describe '#set_entry' do
    it 'remembers the station the journey started from' do
      journey.set_entry(station1)
      expect(journey.current_journey[:entry_station]).to eq station1
    end
  end

  describe '#set_exit' do
    it 'clears entry station on touch out' do
      journey.set_entry(station1)
      journey.set_exit(station2)
      expect(journey.current_journey[:exit_station]).to eq station2
    end
  end

  describe '#fare' do
    it 'returns the minimum fare if journey is complete' do
      journey.set_entry(station1)
      journey.set_exit(station2)
      expect(journey.fare).to eq (Journey::MINIMUM_FARE)
    end

    it 'returns the penalty fare if journey is incomplete' do
      journey.set_entry(station1)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end

  describe 'journey_complete?' do
    it 'returns false if currently in journey' do
      journey.set_entry(station1)
      expect(journey.journey_complete?).to be false
    end

    it 'returns true if the current journey is complete' do
      journey.set_entry(station1)
      journey.set_exit(station2)
      expect(journey.journey_complete?).to be true
    end
  end

end
