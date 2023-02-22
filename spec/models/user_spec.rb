require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Mandatory detail validation - Presence and format' do
    let(:user) {FactoryBot.create(:user)}

    it 'verifies presense of username' do
      user.username = nil
      expect(user.save).to be false

      expect(user.errors.full_messages.first).to eq("Username can't be blank")

      user.username = ''
      expect(user.save).to be false

      expect(user.errors.full_messages.first).to eq("Username can't be blank")
    end

    it 'verifies rfc password format' do
      user.email = 'testemail.com'
      expect(user.save).to be false

      expect(user.errors.full_messages.first).to eq("Email is invalid")
    end

    it 'verifies presense of email' do
      user.email = nil
      expect(user.save).to be false

      expect(user.errors.full_messages.first).to eq("Email can't be blank")
    end

    it 'verifies password of length minimum 6' do
    end

    it 'verifies presense of name' do
      user.name = nil
      expect(user.save).to be false

      expect(user.errors.full_messages.first).to eq("Name can't be blank")

      user.name = ''
      expect(user.save).to be false

      expect(user.errors.full_messages.first).to eq("Name can't be blank")
    end
  end

  describe 'Other detail validation' do
    let(:user) {FactoryBot.create(:user)}
    it 'verifies that Credit card is not mandatory' do
      user.credit_card = nil
      expect(user.save).to be true

      expect(user.errors.full_messages.count).to eq(0)
    end

    it 'verifies that Phone number is not mandatory' do
      user.phone_number = nil
      expect(user.save).to be true

      expect(user.errors.full_messages.count).to eq(0)
    end

    it 'verifies that Credit Card should be of 16 length' do
      user.credit_card = '9999999999'
      expect(user.save).to be false
      
      expect(user.errors.full_messages.first).to eq("Credit card must be 16 digits long")
    end

    it 'verifies that Phone Number should be of 10 length' do
      user.phone_number = '9999'
      expect(user.save).to be false

      expect(user.errors.full_messages.first).to eq("Phone number must be 10 digits long")
    end

    it 'verifies that Credit card should have only digits' do
      user.credit_card = '9999kals99999999'
      expect(user.save).to be false
      
     
      expect(user.errors.full_messages.first).to eq("Credit card must contain only numbers")
    end

    it 'verifies that Phone Number should have only digits' do
      user.phone_number = '9999999gg9'
      expect(user.save).to be false

      expect(user.errors.full_messages.first).to eq("Phone number must contain only numbers")
    end
  end
end
