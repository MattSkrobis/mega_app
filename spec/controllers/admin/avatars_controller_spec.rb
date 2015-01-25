require 'rails_helper'

describe Admin::AvatarsController do
  let!(:user) { create(:user) }
  render_views
  include_context 'admin signed in'

  describe '#index' do
    let(:call_request) { get :index, user_id: user.id }
    let!(:avatar) { create(:avatar, user: user) }

    context 'after request' do
      before { call_request }

      it { should render_template 'index' }
      it { expect(assigns(:avatars)).to eq [avatar] }
    end
  end

  describe '#new' do
    let(:call_request) { get :new, user_id: user.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(assigns(:avatar).persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, user_id: user.id, id: avatar.id }
    let(:avatar) { create(:avatar, user: user) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:avatar)).to eq avatar }

    end
  end

  describe '#show' do
    let(:call_request) { get :show, user_id: user.id, id: avatar.id }
    let(:avatar) { create(:avatar, user: user) }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:avatar)).to eq avatar }
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, user_id: user.id, id: avatar.id }
    let!(:avatar) { create(:avatar, user: user) }

    it { expect { call_request }.to change { Avatar.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to admin_avatars_path }
    end
  end

  describe '#create' do
    let(:call_request) { post :create, avatar: attributes, user_id: user.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:avatar, name: 'Avatar', user_id: user.id) }

      it { expect { call_request }.to change { Avatar.count }.by(1) }

      context 'after request' do
        before { call_request }
        let(:created_avatar) { Avatar.last }

        it { should redirect_to admin_avatar_path(created_avatar) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:avatar, name: nil) }

      it { expect { call_request }.not_to change { Avatar.count } }

      context 'after request' do
        before { call_request }

        it { should render_template 'new' }
      end
    end
  end

  describe '#update' do
    let!(:avatar) { create(:avatar, name: 'Dog') }
    let(:call_request) { put :update, id: avatar.id, user_id: user.id, avatar: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:avatar, name: 'Cat') }

      it { expect { call_request }.to change { avatar.reload.name }.from('Dog').to('Cat') }

      context 'after request' do
        before { call_request }

        it { (expect(assigns(:avatar)).to eq avatar) }
        it { should redirect_to admin_avatar_path(avatar) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:avatar, name: nil) }

      it { expect { call_request }.not_to change { avatar.reload.name } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
        it { expect(assigns(:avatar)).to eq avatar }
      end
    end
  end
end
