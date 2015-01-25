require 'rails_helper'

describe Admin::AuthorsController do
  render_views

  describe '#index' do
    let(:call_request) { get :index }
    let!(:author) { create(:author) }

    context 'after request' do
      before { call_request }

      it { expect(assigns(:authors)).to eq [author] }
      it { should render_template 'index' }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { expect(assigns(:author).persisted?).to be false }
      it { should render_template 'new' }

    end
  end

  describe '#show' do
    let(:author) { create(:author) }
    let(:call_request) { get :show, id: author.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:author)).to eq author }
    end
  end

  describe '#edit' do
    let(:author) { create(:author) }
    let(:call_request) { get :edit, id: author.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:author)).to eq author }
    end
  end

  describe '#destroy' do
    let!(:author) { create(:author) }
    let(:call_request) { delete :destroy, id: author.id }

    it { expect { call_request }.to change { Author.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to admin_authors_path }
    end
  end

  describe '#update' do
    let!(:author) { create(:author, first_name: 'Jodie', last_name: 'Summers') }
    let(:call_request) { put :update, id: author.id, author: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:author, first_name: 'Augusta', last_name: 'Autumn') }

      it { expect { call_request }.to change { author.reload.first_name }.from('Jodie').to('Augusta') }
      it { expect { call_request }.to change { author.reload.last_name }.from('Summers').to('Autumn') }

      context 'after request' do
        before { call_request }

        it { should redirect_to admin_author_path(author) }
        it { expect(assigns(:author)).to eq author }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:author, first_name: nil) }

      it { expect { call_request }.not_to change { author.reload.first_name } }
      it { expect { call_request }.not_to change { author.reload.last_name } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
        it { expect(assigns(:author)).to eq author }
      end
    end
  end

  describe '#create' do
    let(:call_request) { post :create, author: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:author, first_name: 'Alfonso') }

      it { expect { call_request }.to change { Author.count }.by(1) }

      context 'after request' do
        before { call_request }
        let(:created_author) { Author.last }

        it { should redirect_to admin_author_path(created_author) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:author, first_name: nil) }

      it {expect { call_request }.not_to change { Author.count }}

      context 'after request' do
        before { call_request }

        it {should render_template 'new'}
      end
    end
  end
end
