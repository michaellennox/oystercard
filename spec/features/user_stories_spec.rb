describe 'User Stories' do

  let(:oystercard) { Oystercard.new }

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  it 'fare is deducted from the card' do
    oystercard.top_up(50)
    expect{ oystercard.touch_out }.to change{ oystercard.balance }.by (-1)
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
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it 'customer is not in journey after touching out' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.

  it "will not let you through, if balance below minimum balance" do
    expect{oystercard.touch_in}.to raise_error "Must top up oystercard"
  end

  # In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card


  it 'will deduct the correct amount from the user\'s card when he travels' do
    oystercard.top_up(10)
    oystercard.touch_in
    expect{oystercard.touch_out}.to change{oystercard.balance}.by(-1)
  end


  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from

  context 'when touching in at liverpool st' do

    before(:example) do
      oystercard.top_up 10
      oystercard.touch_in :liverpoolst
    end

    it 'will record the latest station you touched in at' do
      expect(ostercard.entry_station).to eq :liverpoolst
    end

    it 'will forget the entry station upon touch out' do
      oystercard.touch_out
      expect(oystercard.entry_station).to be nil
    end
  end

end
