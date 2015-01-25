require 'rails_helper'

describe Admin::UsersController do
  render_views

  describe '#index' do
    let(:call_request) { get :index }
    let!(:user) { create(:user) }

    context 'after request' do
      before { call_request }

      it { expect(assigns(:users)).to eq [user] }
      it { should render_template 'index' }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { expect(assigns(:user).persisted?).to be false }
      it { should render_template 'new' }

    end
  end

  describe '#show' do
    let(:user) { create(:user) }
    let(:call_request) { get :show, id: user.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:user)).to eq user }
    end
  end

  describe '#edit' do
    let(:user) { create(:user) }
    let(:call_request) { get :edit, id: user.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:user)).to eq user }
    end
  end

  describe '#destroy' do
    let!(:user) { create(:user) }
    let(:call_request) { delete :destroy, id: user.id }

    it { expect { call_request }.to change { User.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to admin_users_path }
    end
  end

  describe '#update' do
    let!(:user) { create(:user, first_name: 'Jodie', last_name: 'Summers') }
    let(:call_request) { put :update, id: user.id, user: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:user, first_name: 'Augusta', last_name: 'Autumn') }

      it { expect { call_request }.to change { user.reload.first_name }.from('Jodie').to('Augusta') }
      it { expect { call_request }.to change { user.reload.last_name }.from('Summers').to('Autumn') }

      context 'after request' do
        before { call_request }

        it { should redirect_to admin_user_path(user) }
        it { expect(assigns(:user)).to eq user }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:user, first_name: nil) }

      it { expect { call_request }.not_to change { user.reload.first_name } }
      it { expect { call_request }.not_to change { user.reload.last_name } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
        it { expect(assigns(:user)).to eq user }
      end
    end
  end

  describe '#create' do
    let(:call_request) { post :create, user: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:user, email: 'alfonso@gmail.com') }

      it { expect { call_request }.to change { User.count }.by(1) }

      context 'after request' do
        before { call_request }
        let(:created_user) { User.last }

        it { should redirect_to admin_user_path(created_user) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:user, email: nil) }

      it {expect { call_request }.not_to change { User.count }}

      context 'after request' do
        before { call_request }

        it {should render_template 'new'}
      end
    end
  end
end
