require 'rails_helper'

describe Admin::CommentsController do
  render_views
  let(:book) {create(:book)}
  let(:user) {create(:user)}

  describe '#index' do
    let(:call_request) { get :index, user: user, book: book}
    let!(:comment) { create(:comment) }

    context 'after request' do
      before { call_request }

      it { should render_template 'index' }
      it { expect(assigns(:comments)).to eq [comment] }
    end
  end

  describe '#new' do
    let(:call_request) { get :new, user_id: user.id, book_id: book.id }
    context 'after request' do
      before { call_request }

      it { expect(assigns(:comment).persisted?).to be false }
      it { should render_template 'new' }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: comment.id, user_id: user.id, book_id: book.id }
    let(:comment) { create(:comment, user: user, book: book) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:comment)).to eq comment }
    end
  end

  describe '#show' do
    let(:call_request) { get :show, id: comment.id, user_id: user.id, book_id: book.id }
    let(:comment) { create(:comment, user: user, book: book) }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:comment)).to eq comment }
    end
  end

  describe '#destroy' do
    let!(:comment) { create(:comment, user: user, book: book) }
    let(:call_request) { delete :destroy, id: comment.id, user_id: user.id, book_id: book.id }

    it { expect { call_request }.to change { Comment.count }.by(-1) }

    context 'after request' do
      before { call_request }
      it { should redirect_to admin_comments_path }
    end
  end

  describe '#create' do
    let(:call_request) { post :create, comment: attributes, user: user, book: book }

    context 'valid request' do
      let(:attributes) { attributes_for(:comment, rating: 3, user_id: user.id, book_id: book.id) }

      it { expect { call_request }.to change { Comment.count }.by(1) }
      context 'after request' do
        let(:created_comment) { Comment.last }
        before { call_request }

        it { should redirect_to admin_comment_path(created_comment) }

      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:comment, rating: nil, user_id: user.id, book_id: book.id) }

      it { expect { call_request }.not_to change { Comment.count } }
      context 'after request' do
        before { call_request }
        it { should render_template 'new' }
      end
    end
  end

  describe '#update' do
    let!(:comment) { create(:comment, rating: 2, user: user, book: book) }
    let(:call_request) { put :update, comment: attributes, id: comment.id, user_id: user.id, book_id: book.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:comment, rating: 9) }

      it { expect { call_request }.to change { comment.reload.rating }.from(2).to(9) }

      context 'after request' do
        before { call_request }

        it { expect(assigns(:comment)).to eq comment }
        it { should redirect_to admin_comment_path(comment) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:comment, rating: nil) }

      it { expect { call_request }.not_to change { comment.reload.rating } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
        it { expect(assigns(:comment)).to eq comment }
      end
    end
  end
end
