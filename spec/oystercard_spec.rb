require 'oystercard'


describe Oystercard do
subject(:card) {described_class.new}
let(:rand_num) {rand(1..40)}
let(:entry_station){ double :station }
let(:exit_station) { double :station }
 it 'A new card will defult have a balance of 0' do
  expect(card.balance).to eq 0

end

describe '#top_up' do

 it 'Should add money onto the balance' do
  expect(card).to respond_to(:top_up).with(1).argument
end

 it 'money added onto the balance should increase the total by that amount' do
  expect{card.top_up(10)}.to change{ card.balance }.by 10
end

it 'should not allow a balance to exceed limit' do
  max_balance = Oystercard::BALANCE_LIMIT
  card.top_up(max_balance)
  expect{card.top_up(1)}.to raise_error "Error £#{max_balance} limit exceeded"
end


end

describe '#pay' do
  it 'should deduct money from balance' do
    expect(card).to respond_to(:pay).with(1).argument
  end
  it 'should deduct the correct amount from balance' do
    card.top_up(20)
    expect{card.pay(3)}.to change{card.balance}.by -3
  end


end

describe '#Journey_Status' do
  it 'should allow the card to touch in' do
    expect(card).to respond_to(:touch_in)
  end
  it 'should allow the card to touch out' do
    expect(card).to respond_to(:touch_out)
  end
  it 'should display if card is within a journey or not' do
    expect(card).to respond_to(:in_journey?)
  end
  it 'should raise an error if balance is less than the BALANCE_MIN' do
    min_balance=Oystercard::BALANCE_MIN
    expect{card.touch_in(entry_station)}.to raise_error "Error minimum balance to touch in is #{min_balance}"
  end
  it 'should deduct the fare from the balance after touching out' do
fare = Oystercard::FARE
    card.top_up(rand_num)
    card.touch_in(entry_station)
    expect{card.touch_out(exit_station)}.to change{card.balance}.by(-fare)
  end
  it 'card should remeber station it touched in at' do
    card.top_up(rand_num)
    card.touch_in(entry_station)
    expect(card.entry_station).to eq entry_station

  end
  it 'card should remeber station it touched out at' do
    card.top_up(rand_num)
    card.touch_in(entry_station)
    card.touch_out(exit_station)
    expect(card.exit_station).to eq exit_station
end

describe '#in_journey' do
  it 'in_journey should be true after touching in' do
    card.top_up(rand_num)
    card.touch_in(entry_station)
    expect(card.in_journey?).to eq entry_station
  end
  it 'in_journey should be false after touching out' do
    card.top_up(rand_num)
    card.touch_in(entry_station)
    card.touch_out(exit_station)
    expect(card.in_journey?).to eq nil
  end


end
end

describe '#journeys' do
  it 'should store entry station into a hash' do
    card.top_up(rand_num)
    card.touch_in(entry_station)
    expect(card.journeys["Entry"]).to eq entry_station
  end
end
end
