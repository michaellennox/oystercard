require 'journeylog'

describe JourneyLog do

  subject(:journeylog) { described_class.new }

  it 'should initialize with an empty array to log the journies' do
    expect (journeylog.history).to eq []
  end

end
