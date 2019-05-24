require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    before { get :new }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end
    it 'assigns new @user' do
      expect(assigns(:user)).to be_a_new User
    end
    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:user_attributes) { FactoryBot.attributes_for(:user) }

    it 'saves new user' do
      expect do
        post :create, params: { user: user_attributes }
      end.to change(User, :count).by(1)
    end
  end
end