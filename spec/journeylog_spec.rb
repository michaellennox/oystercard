require 'journeylog'

describe JourneyLog do

  subject(:journeylog) { described_class.new(journey: journey) }
  let(:journey) { double :journey }
  let(:station1) { double :station }

  it 'should initialize with an empty array to log the journies' do
    expect(journeylog.history).to eq []
  end

  describe '#start_journey' do
    it 'should start a new journey' do
      journeylog.start_journey(station1)
      expect(journeylog.current_journey).to
    end
  end

end
