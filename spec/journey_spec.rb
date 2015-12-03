require 'journey'

describe Journey do
  subject(:journey) {described_class.new}
  let(:card) {double(:oystercard)}
  let(:minimum_fare) {Oystercard::MINIMUM_FARE}
  let(:station1) {double(:station)}
  let(:station2) {double(:station)}

  describe '#initialize' do
    it 'is initially not in a journey' do
      expect(journey.current_journey[:entry_station]).to eq(nil)
    end
  end

  describe '#touch_in' do
    it 'remembers the station the journey started from' do
      journey.touch_in(station1)
      expect(journey.current_journey[:entry_station]).to eq station1
    end
  end

  describe '#touch_out' do
    it 'clears entry station on touch out' do
      journey.touch_in(station1)
      journey.touch_out(station2)
      expect(journey.current_journey[:exit_station]).to eq station2
    end
  end


end
