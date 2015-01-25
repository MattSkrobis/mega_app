require 'rails_helper'

describe BooksController do
  render_views
  let(:author) {create(:author)}
  let(:publisher) {create(:publisher)}

  describe '#index' do
    let!(:book) { create(:book, author: author, publisher: publisher) }
    let(:call_request) { get :index }

    context 'after request' do
      before { call_request }

      it { should render_template 'index' }
      it { expect(assigns(:books)).to eq [book] }

    end
  end

  describe '#show' do
    let(:book) { create(:book, author: author, publisher: publisher) }
    let(:call_request) { get :show, id: book.id, author_id: author.id, publisher_id: publisher.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:book)).to eq book }
    end
  end
end
