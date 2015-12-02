require 'station'


describe Station do
    subject {described_class.new(name: "Old Street", zone: 1)}
describe '#name' do
  it 'should save a name when creating a new station'do

    expect(subject.name).to eq ("Old Street")
  end
end

describe '#zone' do
  it 'should save a zone when creating a new station' do

    expect(subject.zone).to eq(1)
  end
end





end
