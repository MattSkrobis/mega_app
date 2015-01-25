require 'rails_helper'

describe Editor::CommentsController do
  render_views
  include_context 'editor signed in'

  let!(:book) { create(:book) }
  let!(:user) { create(:user) }

  describe '#edit' do
    let(:comment) { create(:comment, user: user, book: book) }
    let(:call_request) { get :edit, book_id: book.id, id: comment.id, user_id: user.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:comment)).to eq comment }
    end
  end

  describe '#delete' do
    let!(:comment) { create(:comment, user: user, book: book) }
    let(:call_request) { delete :destroy, book_id: book.id, id: comment.id }

    it { expect { call_request }.to change { Comment.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to editor_book_path(book) }
    end
  end

  describe '#update' do
    let!(:comment) { create(:comment, rating: 3, user: user, book: book) }
    let(:call_request) { put :update, comment: attributes, id: comment.id, book_id: book.id }

    context "valid request" do
      let(:attributes) { attributes_for(:comment, rating: 6) }

      it { expect { call_request }.to change { comment.reload.rating }.from(3).to(6) }

      context 'after request' do
        before { call_request }

        it { should redirect_to editor_book_path(book) }
        it { expect(assigns(:comment)).to eq comment }
      end
    end

    context "invalid request" do
      let(:attributes) { attributes_for(:comment, rating: nil) }

      it { expect { call_request }.not_to change { comment.reload.rating } }

      context 'after request' do
        before { call_request }

        it { should render_template 'editor/books/show' }
        it { expect(assigns(:comment)).to eq comment }
      end
    end
  end
end
