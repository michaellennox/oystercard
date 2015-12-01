require 'oystercard'

describe Oystercard do

  subject(:card) {described_class.new}

  it 'should have a balance of 0' do
    expect(card.balance).to eq 0
  end

  it 'should return false when not being used in a journey' do
    expect(card).not_to be_in_journey
  end

  it 'should increase the existing balance by an amount' do
      expect{ card.top_up(1) }.to change {card.balance}.by 1
  end

  it 'should raise an error when user tries to touch in if balance is lower than 1' do
    expect {card.touch_in}.to raise_error "Your balance is too low. Please top up!"
  end

  context 'while it has a working balance' do

    before do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
    end

    it 'should return in journey true after touch in is called' do
      card.touch_in
      expect(card).to be_in_journey
    end

    it 'should return in journey false after touch out is called' do
      card.touch_in
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it 'should raise an error if the amount exceeds the limit' do
      amount = 5
      expect{ card.top_up(amount)}.to raise_error("card limit of #{Oystercard::MAXIMUM_BALANCE} exceeded")
    end

    it 'should return the updated balance when money is deducted' do
      amount = 5
      expect(card.deduct(amount)).to eq Oystercard::MAXIMUM_BALANCE - amount
    end

    it 'should raise error if the amount goes below 0' do
      amount = 5
      expect{card.deduct(Oystercard::MAXIMUM_BALANCE+amount)}.to raise_error "you don't have enough money"
    end

    it 'should, on touch out, update the balance deducting the journey fare' do
      card.touch_in
      card.touch_out
      expect(card.balance).to eq Oystercard::MAXIMUM_BALANCE - Oystercard::MINIMUM_FARE
    end

  end


end
