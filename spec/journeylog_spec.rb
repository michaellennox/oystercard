require 'journeylog'

describe JourneyLog do

  subject(:journeylog) { described_class.new(journey: journeyinit) }
  let(:journeyinit) { double :journey, new: journey }
  let(:journey) { double :journey }
  let(:station1) { double :station }

  it 'should initialize with an empty array to log the journies' do
    expect(journeylog.history).to eq []
  end

  describe '#new_journey' do
    it 'should start a new journey' do
      expect(journeyinit).to receive(:new)
      journeylog.new_journey
    end
  end

  describe '#start_journey' do
    it 'should start a new journey and give it an entry station' do
      expect(journey).to receive(:set_entry).with(station1)
      journeylog.start_journey(station1)
    end
  end
end
