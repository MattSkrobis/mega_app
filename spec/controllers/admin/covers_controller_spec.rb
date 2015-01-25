require 'rails_helper'

describe Admin::CoversController do
  let!(:book) { create(:book) }
  render_views
  include_context 'admin signed in'

  describe '#index' do
    let(:call_request) { get :index, book_id: book.id }
    let!(:cover) { create(:cover, book: book) }

    context 'after request' do
      before { call_request }

      it { should render_template 'index' }
      it { expect(assigns(:covers)).to eq [cover] }
    end
  end

  describe '#new' do
    let(:call_request) { get :new, book_id: book.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(assigns(:cover).persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, book_id: book.id, id: cover.id }
    let(:cover) { create(:cover, book: book) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:cover)).to eq cover }

    end
  end

  describe '#show' do
    let(:call_request) { get :show, book_id: book.id, id: cover.id }
    let(:cover) { create(:cover, book: book) }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:cover)).to eq cover }
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, book_id: book.id, id: cover.id }
    let!(:cover) { create(:cover, book: book) }

    it { expect { call_request }.to change { Cover.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to admin_covers_path }
    end
  end

  describe '#create' do
    let(:call_request) { post :create, cover: attributes, book_id: book.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:cover, name: 'Cover', book_id:book.id) }

      it { expect { call_request }.to change { Cover.count }.by(1) }

      context 'after request' do
        before {call_request}
        let(:created_cover) { Cover.last }

        it { should redirect_to admin_cover_path(created_cover) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:cover, name: nil) }

      it { expect { call_request }.not_to change { Cover.count } }

      context 'after request' do
        before { call_request }

        it { should render_template 'new' }
      end
    end
  end

  describe '#update' do
    let!(:cover) { create(:cover, name: 'Dog') }
    let(:call_request) { put :update, id: cover.id, book_id: book.id, cover: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:cover, name: 'Cat') }

      it { expect { call_request }.to change { cover.reload.name }.from('Dog').to('Cat') }

      context 'after request' do
        before { call_request }

        it {(expect(assigns(:cover)).to eq cover)}
        it { should redirect_to admin_cover_path(cover) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:cover, name: nil) }

      it { expect{call_request}.not_to change {cover.reload.name} }

      context 'after request' do
        before { call_request }

        it {should render_template 'edit'}
        it { expect(assigns(:cover)).to eq cover }
      end
    end
  end
end
