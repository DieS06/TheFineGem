require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'generates unique emails for each user' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    expect(user1.email).not_to eq(user2.email)
  end

  it 'is invalid without an email' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without an existing password' do
    user = FactoryBot.build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without an existing role' do
    user = FactoryBot.build(:user, role: nil)
    expect(user).not_to be_valid
  end
end
