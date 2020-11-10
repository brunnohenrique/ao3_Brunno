require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let!(:login) { login_as(user) }

  describe 'GET #index' do
    let!(:users) { FactoryBot.create_list(:user, 5) }

    before { get users_path }

    it { is_expected.to render_template(:index) }

    it { expect(response).to be_successful }

    it { expect(assigns(:users).count).to eq 6 }
  end

  describe 'GET #new' do
    before { get new_user_path }

    it { expect(response).to render_template(:new) }

    it 'initializing a new user' do
      expect(assigns(:user)).to be_a User
    end
  end
  
  describe 'GET #show' do
    before { get user_path(user) }

    it { expect(response).to render_template(:show) }

    it 'initializing a new user' do
      expect(assigns(:user)).to have_attributes(
          name: user.name,
          login: user.login,
          email: user.email
        )
    end
  end

  describe 'POST #create' do
    subject { post users_path, params: { user: params } }

    context 'with invalid params' do
      let(:params) { attributes_for(:user, login: '') }

      it 'should not create an user' do
        expect { subject }.not_to change(User, :count)
      end
    end

    context 'with valid params' do
      let(:params) do
        {
          name: 'Brunno Souza',
          login: 'brunno',
          email: 'brunno@ao3.com',
          password: 'password',
          password_confirmation: 'password'
        }
      end

      it { expect { subject }.to change(User, :count).by(1) }

      it 'creates a new user attributes' do
        subject
        expect(assigns(:user)).to have_attributes(
          name: params[:name],
          login: params[:login],
          email: params[:email]
        )
      end
    end
  end

  describe 'GET #edit' do
    before { get edit_user_path(user) }

    it { is_expected.to render_template(:edit) }

    it 'initializing the given user' do
      expect(assigns(:user)).to be_a(User) &
        have_attributes(id: user.id)
    end
  end

  describe 'PUT #update' do
    subject(:update_user_path) { put user_path(user), params: { user: user_params } }

    context 'when the params are invalid' do
      let(:user_params) { { name: '', email: '' } }

      it 'should not update the user' do
        expect do
          update_user_path
          user.reload
        end.not_to change(user, :name)
      end
    end

    context 'when the params are valids' do
      let(:user_params) { { name: 'User Name Changed' } }

      it 'updates the names user' do
        expect do
          update_user_path
          user.reload
        end.to change(user, :name).to(user_params[:name])
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:users) { FactoryBot.create_list(:user, 5) }
    subject(:delete_user_path) { delete user_path(users.first.id) }

    it 'delete the user' do
      expect { delete_user_path }.to change(User, :count).by(-1)
    end
  end
end
