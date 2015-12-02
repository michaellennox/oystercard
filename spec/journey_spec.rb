require 'journey'

describe Journey do

  let(:station) { double(:station) }
  subject(:journey) { Journey.new station }

  describe '#initialisation' do
    it 'should on initialisation record the entry station' do
      expect(journey.journey[:entry]).to eq station
    end
  end

  describe '#in_journey?' do
    it 'should return true on initialization' do
      expect(journey).to be_in_journey
    end

    it 'should return false after journey ended' do
      journey.update_exit(double :station)
      expect(journey).not_to be_in_journey
    end
  end
end
