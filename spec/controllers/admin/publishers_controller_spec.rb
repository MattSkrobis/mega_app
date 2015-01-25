require 'rails_helper'

describe Admin::PublishersController do
  render_views

  describe '#index' do
    let(:call_request) { get :index }
    let!(:publisher) { create(:publisher) }

    context 'after request' do
      before { call_request }

      it { expect(assigns(:publishers)).to eq [publisher] }
      it { should render_template 'index' }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { expect(assigns(:publisher).persisted?).to be false }
      it { should render_template 'new' }

    end
  end

  describe '#show' do
    let(:publisher) { create(:publisher) }
    let(:call_request) { get :show, id: publisher.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:publisher)).to eq publisher }
    end
  end

  describe '#edit' do
    let(:publisher) { create(:publisher) }
    let(:call_request) { get :edit, id: publisher.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:publisher)).to eq publisher }
    end
  end

  describe '#destroy' do
    let!(:publisher) { create(:publisher) }
    let(:call_request) { delete :destroy, id: publisher.id }

    it { expect { call_request }.to change { Publisher.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to admin_publishers_path }
    end
  end

  describe '#update' do
    let!(:publisher) { create(:publisher, name: 'Jodie')}
    let(:call_request) { put :update, id: publisher.id, publisher: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:publisher, name: 'Augusta') }

      it { expect { call_request }.to change { publisher.reload.name }.from('Jodie').to('Augusta') }

      context 'after request' do
        before { call_request }

        it { should redirect_to admin_publisher_path(publisher) }
        it { expect(assigns(:publisher)).to eq publisher }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:publisher, name: nil) }

      it { expect { call_request }.not_to change { publisher.reload.name } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
        it { expect(assigns(:publisher)).to eq publisher }
      end
    end
  end

  describe '#create' do
    let(:call_request) { post :create, publisher: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:publisher, name: 'Alfonso') }

      it { expect { call_request }.to change { Publisher.count }.by(1) }

      context 'after request' do
        before { call_request }
        let(:created_publisher) { Publisher.last }

        it { should redirect_to admin_publisher_path(created_publisher) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:publisher, name: nil) }

      it {expect { call_request }.not_to change { Publisher.count }}

      context 'after request' do
        before { call_request }

        it {should render_template 'new'}
      end
    end
  end
end
