require 'station'

describe Station do

subject(:station) {described_class.new(name: "Old Street", zone: 1)}

describe "knows it's name and where it is" do
  it 'allows a stations zone to be seen' do
    station = Station.new('Aldgate', 3)
    expect(station.zone).to eq 3
  end

  it 'allows a different stations zone to be seen' do
    station = Station.new('Euston', 2)
    expect(station.zone).to eq 2
  end

  it 'allows a stations name to be seen' do
    station = Station.new('Euston', 2)
    expect(station.name).to eq 'Euston'
  end
end


end
