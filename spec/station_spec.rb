require 'station'

describe Station do

subject(:station) {described_class.new(3)}

  it 'allows a stations zone to be seen' do
    expect(station.zone).to eq 3
  end



end
