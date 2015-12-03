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
    it 'returns the minimum fare' do
      expect(journey.fare).to eq (Journey::MINIMUM_FARE)
    end
  end

  describe 'in_journey?' do
    it 'returns true if currently in journey' do
      journey.set_entry(station1)
      expect(journey.in_journey?).to be true
    end

    it 'returns false if not currently in journey' do
      expect(journey.in_journey?).to be false
    end
  end

end
