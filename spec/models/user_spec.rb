require 'rails_helper'

describe User do
  it { should validate_presence_of(:nickname) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:encrypted_password) }
  it { should validate_presence_of(:age) }
  it { should validate_numericality_of(:age) }
  it { should have_many(:comments) }
  it { should have_one(:avatar) }

  describe '#to_s' do
    let(:user) { create(:user, first_name: 'Claire', last_name: 'Fitzpatrick') }

    it 'should return first name and last name of an user' do
      expect(user.to_s).to eq 'Claire Fitzpatrick'
    end
  end
end
