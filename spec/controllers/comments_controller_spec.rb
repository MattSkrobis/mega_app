require 'rails_helper'

describe CommentsController do
  render_views
  let(:user) { create(:user) }
  let!(:book) { create(:book) }

  # NO INDEX

  describe '#new' do
    let(:call_request) { get :new, book_id: book.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(assigns(:comment).persisted?).to be false }
    end
  end

  describe '#edit' do
    include_context 'user signed in'

    let(:call_request) { get :edit, book_id: book.id, id: comment.id }
    let(:comment) { create(:comment, book: book, user: user) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:comment)).to eq comment }
    end
  end

  describe '#delete' do
    include_context 'user signed in'

    let!(:comment) { create(:comment, book: book) }
    let(:call_request) { delete :destroy, id: comment.id, book_id: book.id }

    it { expect { call_request }.to change { Comment.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to book_path(book) }
    end
  end

  describe '#create' do
    let(:call_request) { post :create, comment: attributes, book_id: book.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:comment, user_id: user.id) }

      it { expect { call_request }.to change { Comment.count }.by(1) }

      context 'after request' do
        before { call_request }
        let(:created_comment) { Comment.last }

        it { should redirect_to book_path(book) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:comment, description: nil) }

      it { expect { call_request }.not_to change { Comment.count } }

      context 'after request' do
        before { call_request }

        it { should render_template 'books/show' }
      end
    end
  end

  describe '#update' do
    let!(:comment) { create(:comment, rating: 9, book: book) }
    let(:call_request) { put :update, comment: attributes, id: comment.id, book_id: book.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:comment, rating: 2) }

      it { expect { call_request }.to change { comment.reload.rating }.from(9).to(2) }

      context 'after request' do
        before { call_request }

        it { should redirect_to book_path(book) }
        it { expect(assigns(:comment)).to eq comment }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:comment, rating: nil, book: book) }

      it { expect { call_request }.not_to change { comment.reload.rating } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
        it { expect(assigns(:comment)).to eq comment }
      end
    end
  end
end
