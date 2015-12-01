require 'station'

describe Station do

  subject(:station) { Station.new :station, 1}

  describe '#zone' do
    it 'should give the zone of the station' do
      expect(station.zone).to eq 1
    end
  end

  describe '#name' do
    it 'should give the name of the station' do
      expect(station.name).to eq :station
    end
  end

end
