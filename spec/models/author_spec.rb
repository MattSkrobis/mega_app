require 'rails_helper'

describe Author do
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:age) }
  it { should validate_numericality_of(:age) }
  it { should have_many(:books) }

  describe '#to_s' do
    let(:author) { create(:author, first_name: 'Helen', last_name: 'Hunt') }

    it 'should return full name of author' do
      expect(author.to_s).to eq 'Helen Hunt'
    end
  end
end
