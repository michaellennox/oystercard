require 'station'

describe Station do

  subject(:station) { Station.new :station, 1}

  it {is_expected.to respond_to(:zone)}

end
