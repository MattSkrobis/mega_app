require 'rails_helper'

describe Book do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:publisher) }
  it { should validate_presence_of(:edition) }
  it { should validate_presence_of(:publisher) }
  it { should validate_presence_of(:genre) }
  it { should have_many(:comments) }
  it { should have_one(:cover) }

  describe '#to_s' do
    let(:book) { create(:book, title: '10 Pro Tips on FPS Gaming') }

    it 'should return the title of a book' do
      expect(book.to_s).to eq '10 Pro Tips on FPS Gaming'
    end
  end
end
