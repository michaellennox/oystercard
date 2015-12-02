describe "Feature Tests" do
  let(:card) {Oystercard.new}
  let(:maximum_balance) {Oystercard::MAXIMUM_BALANCE}
  let(:minimum_fare) {Oystercard::MINIMUM_FARE}
  let(:station) {Station.new(:name, :zone)}

  describe 'Oystercard' do
    describe '#initialize Oystercard' do
      it 'is initially not in a journey' do
        expect(card.current_journey[:entry_station]).to eq(nil)
      end
    end

    describe 'behaviour of balance on the card' do
      it 'creates a card with a balance' do
        expect(card.balance).to eq 0
      end

      it 'tops up the card by a value and returns the balance' do
        expect{card.top_up(1)}.to change{card.balance}.by(1)
      end

      it 'will not allow balance to exceed maximum balance' do
        card.top_up(maximum_balance)
        expect{card.top_up(1)}.to raise_error("Maximum balance of £#{maximum_balance} exceeded")
      end
    end

    describe '#touch_in' do
      it 'allows a card to touch in and begin journey if balance greater than minimum fare' do
        card.top_up(minimum_fare)
        card.touch_in(station)
        expect(card.current_journey[:entry_station]).to eq(station)
      end

      it 'raise error if card balance is zero' do
        expect{card.touch_in(station)}.to raise_error "Insufficent funds: top up"
      end

      it 'remembers the station the journey started from' do
        card.top_up(minimum_fare)
        card.touch_in(station)
        expect(card.current_journey[:entry_station]).to eq station
      end
    end

    describe '#touch_out' do
      it 'allows a card to touch out and end a journey' do
          card.touch_out(station)
          expect(card.current_journey[:entry_station]).to eq(nil)
      end

      it 'charges customer when they tap out' do
        expect{card.touch_out((station))}.to change{card.balance}.by(-minimum_fare)
      end

      it 'clears the entry station upon touch out' do
        card.top_up(minimum_fare)
        card.touch_in(station)
        card.touch_out((station))
        expect(card.current_journey[:entry_station]).to eq nil
      end

    end

    describe 'previous journeys' do
      it 'can recall all previous journeys' do
        entry_station = double(:station)
        exit_station = double(:station)
        card.top_up(minimum_fare)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.journey_history).to eq [{entry_station: entry_station, exit_station: exit_station}]
      end
    end
  end

  describe 'Station' do
    it 'allows you to see what zone a station is in' do
      station = Station.new('Aldgate', 3)
      expect(station.zone).to eq 3
    end

    it 'allows you to see what zone a station is in' do
      station = Station.new('Euston', 2)
      expect(station.zone).to eq 2
    end

    it 'allows you to see the stations name' do
      station = Station.new('Aldgate', 3)
      expect(station.name).to eq 'Aldgate'
    end

    it 'allows a stations name to be seen' do
      station = Station.new('Euston', 2)
      expect(station.name).to eq 'Euston'
    end
  end

  describe 'Journey' do
# In order to be charged correctly
# As a customer
# I need a penalty charge deducted if I fail to touch in or out
  it 'deducts a penalty charge if I fail to touch in' do
    card.top_up(20)
    expect { card.touch_out(station) }.to change { card.balance }.by -6
  end



  end

end