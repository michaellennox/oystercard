require 'journey'


describe Journey do
  subject(:journey) { described_class.new }
  let(:station) { double :station }
  let(:station2) { double :station }

  it 'should initialize with an empty hash to log journeys' do
    expect(journey.journeys).to eq ({})
  end

  describe '#journeys' do
    it 'should store both the entry and exit station into a hash' do
      journey.log_entry(station)
      journey.log_exit(station2)
      journey.log_entry(station2)
      journey.log_exit(station)
      expect(journey.journeys).to eq ({1=>[station, station2], 2=>[station2, station]})
    end
  end

  describe '#journey_complete?' do
    it 'should return true when journey is complete' do
      journey.log_entry(station)
      journey.log_exit(station)
      expect(journey.journey_complete?).to be true
    end

    it 'should return false when journey is not complete' do
      journey.log_entry(station)
      expect(journey.journey_complete?).to be false
    end

    it 'should return true before journey starts' do
      expect(journey.journey_complete?).to be true
    end
  end

end
