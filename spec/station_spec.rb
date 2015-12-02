require 'station'

describe Station do

subject(:station) {described_class.new}

  it 'allows a stations zone to be seen' do
    station = Station.new('Aldgate', 3)
    expect(station.zone).to eq 3
  end

  it 'allows you to see what zone a station is in' do
    station = Station.new('Euston', 2)
    expect(station.zone).to eq 2
  end

  it 'allows a stations name to be seen' do
    station = Station.new('Euston', 2)
    expect(station.name).to eq 'Euston'
  end



end
