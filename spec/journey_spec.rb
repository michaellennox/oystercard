require 'journey'

describe Journey do

  subject(:journey) {Journey.new double(:staion)}

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
