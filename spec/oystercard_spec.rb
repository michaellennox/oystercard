require 'oystercard'


describe Oystercard do
subject(:card) {described_class.new}

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


end

end
