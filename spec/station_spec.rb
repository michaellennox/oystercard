require 'station'

describe Station do

  subject(:station) {described_class.new(:liverpoolst, 4)}

  describe '#zone' do
    it 'returns the zone the station is in' do
      expect(station.zone).to eq 4
    end
  end

  describe '#station_name' do
    it 'returns the name of the station' do
      expect(station.station_name).to eq :liverpoolst
    end
  end


end
