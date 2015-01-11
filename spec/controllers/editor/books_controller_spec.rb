require 'rails_helper'

describe Editor::BooksController do
  render_views

  describe '#index' do
    let(:call_request) { get :index }
    let!(:book) { create(:book) }

    context 'after request' do
      before { call_request }

      it { should render_template 'index' }
      it {expect(assigns(:books)).to eq [book]}
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(assigns(:book).persisted?).to be false }
    end
  end

  describe '#edit' do
    render_views
    let(:call_request) { get :edit, id: book.id }
    let(:book) { create(:book) }


    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:book)).to eq book }
    end
  end

  describe '#show' do
    let(:book) { create(:book) }
    let(:call_request) { get :show, id: book.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:book)).to eq book }
    end
  end

  describe '#destroy' do
    let!(:book) { create(:book) }
    let(:call_request) { delete :destroy, id: book.id }

    it { expect { call_request }.to change { Book.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to editor_books_path }
    end
  end

  describe '#create' do
    let(:call_request) { post :create, book: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:book, title: '1q83') }

      it { expect { call_request }.to change { Book.count }.by(1) }

      context 'after request' do
        let(:created_book) { Book.last }
        before { call_request }

        it { should redirect_to editor_book_path(created_book) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:book, title: nil) }

      it { expect { call_request }.not_to change { Book.count } }

      context 'after request' do
        before { call_request }

        it { should render_template 'new' }
      end
    end
  end
  describe '#update' do
    let!(:book) { create(:book, title: 'A Boy Called Kafka', author: 'Haruki Murakami') }
    let(:call_request) { put :update, book: attributes, id: book.id }


    context 'valid request' do
      let(:attributes) { attributes_for(:book, title: "Red Army's Tanks and AFVs", author: "David Porter") }

      it { expect { call_request }.to change { book.reload.title }.from('A Boy Called Kafka').to("Red Army's Tanks and AFVs") }
      it { expect { call_request }.to change { book.reload.author }.from('Haruki Murakami').to("David Porter") }

      context 'after request' do
        before { call_request }

        it { should redirect_to editor_book_path(book) }
        it { expect(assigns(:book)).to eq book }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:book, title: nil, author: nil) }

      it { expect { call_request }.not_to change { book.reload.title } }
      it { expect { call_request }.not_to change { book.reload.author } }


      context 'after request' do
        before { call_request }

        it {should render_template 'edit'}
        it {expect(assigns(:book)).to eq book}
      end
    end
  end
end
