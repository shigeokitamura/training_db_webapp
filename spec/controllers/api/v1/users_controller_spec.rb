require 'rails_helper'

module Api
  module V1
    RSpec.describe Api::V1::UsersController, type: :controller do
      describe 'GET #show' do
        let!(:user) { FactoryBot.create(:user) }
        let!(:course) { FactoryBot.create(:course) }
        
        it 'has a 200 status code' do
          get :show, params: { id: user.id, user_name: user.user_name, password: user.password }
          expect(response).to have_http_status(:ok)
        end

        it 'has a correct JSON data' do
          get :show, params: { id: user.id, user_name: user.user_name, password: user.password }
          json = JSON.parse(response.body)
          expect(json['status']).to eq('SUCCESS')
        end

        it 'contains a orderd course' do
          user.buy(course)
          get :show, params: { id: user.id, user_name: user.user_name, password: user.password }
          json = JSON.parse(response.body)
          expect(json['data'].first['course_id']).to eq(course[:course_id])
        end

        it 'should not return data without username' do
          user.buy(course)
          get :show, params: { id: user.id }
          json = JSON.parse(response.body)
          expect(json['status']).to eq('ERROR')
        end

        it 'should not return data with invalid password' do
          user.buy(course)
          get :show, params: { id: user.id, user_name: user.user_name, password: user.password + 'a' }
          json = JSON.parse(response.body)
          expect(json['status']).to eq('ERROR')
        end
      end

    end
  end
end
