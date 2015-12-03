require 'journeylog'

describe JourneyLog do

  subject(:journeylog) { described_class.new(journey: journeyinit) }
  let(:journeyinit) { double :journey, new: journey }
  let(:journey) { double :journey, set_entry: nil, set_exit: nil, current_journey: nil, fare: nil, complete?: true }
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

  describe '#end_journey' do
    it 'should give the current journey the exit station' do
      expect(journey).to receive(:set_exit).with(station1)
      journeylog.start_journey(station1)
      journeylog.end_journey(station1)
    end
  end

  describe '#outstanding_charges' do
    it 'should return a fare returned by the journey' do
      allow(journey).to receive(:fare).and_return(1)
      journeylog.start_journey(station1)
      journeylog.end_journey(station1)
      expect(journeylog.outstanding_charges).to eq 1
    end
  end

  describe '#history' do
    it 'should return a list of journeys carried out' do
      allow(journey).to receive(:current_journey).and_return({entry_station: station1, exit_station: station1})
      journeylog.start_journey(station1)
      journeylog.end_journey(station1)
      expect(journeylog.history).to include ({entry_station: station1, exit_station: station1})
    end
  end
end
