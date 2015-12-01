describe 'User Stories' do

  let(:oystercard) { Oystercard.new }
  let(:station) { Station.new(:station, 1)}

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  it 'fare is deducted from the card' do
    oystercard.top_up(50)
    expect{ oystercard.touch_out(station) }.to change{ oystercard.balance }.by (-1)
  end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.

  context 'card has a working balance' do

    before(:example) { oystercard.top_up 10 }

    it 'by default customer not in journey' do
      expect(oystercard).not_to be_in_journey
    end

    it 'customer is in journey after touching in' do
      oystercard.touch_in(station)
      expect(oystercard).to be_in_journey
    end

    it 'customer is not in journey after touching out' do
      oystercard.touch_in(station)
      oystercard.touch_out(station)
      expect(oystercard).not_to be_in_journey
    end
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.

  it "will not let you through, if balance below minimum balance" do
    expect{oystercard.touch_in(station)}.to raise_error "Must top up oystercard"
  end

  # In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card


  it 'will deduct the correct amount from the user\'s card when he travels' do
    oystercard.top_up(10)
    oystercard.touch_in(station)
    expect{oystercard.touch_out(station)}.to change{oystercard.balance}.by(-1)
  end


  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from

  context 'when touching in at liverpool st' do

    before(:example) do
      oystercard.top_up 10
      oystercard.touch_in station
    end

    it 'will record the latest station you touched in at' do
      expect(oystercard.entry_station).to eq station
    end

    it 'will forget the entry station upon touch out' do
      oystercard.touch_out(station)
      expect(oystercard.entry_station).to be nil
    end
  end

  # In order to know where I have been
  # As a customer
  # I want to see to all my previous trips


  let(:oldst) {double :station}
  let(:moorgate) {double :station}
  let(:liverpoolst) {double :station}
  let(:kingsx) {double :station}

  it 'will store all previous trips in the journey_list variable' do
    oystercard.top_up(50)
    oystercard.touch_in(oldst)
    oystercard.touch_out(moorgate)
    oystercard.touch_in(liverpoolst)
    oystercard.touch_out(kingsx)
    expect(oystercard.journey_list).to eq({ oldst => moorgate, liverpoolst => kingsx })
  end

  # In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in

  it 'station information is callable by the customer' do
    expect(station.zone).to eq 1
  end
end
