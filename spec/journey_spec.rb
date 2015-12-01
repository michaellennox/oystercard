require 'journey'

describe Journey do

  subject(:journey) {described_class.new}

  describe '#journey_list' do
    it 'is expected to initialize as an empty hash' do
      expect(journey.journey_list).to eq({})
    end
  end

end
