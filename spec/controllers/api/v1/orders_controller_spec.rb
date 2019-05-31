require 'rails_helper'

module Api
  module V1
    RSpec.describe Api::V1::OrdersController, type: :controller do
      describe 'GET #index' do
        let(:order) { FactoryBot.create(:order) }
        before { get :index }
        it 'has a 200 status code' do
          expect(response).to have_http_status(:ok)
        end
        it 'has a success status' do
          json = JSON.parse(response.body)
          expect(json['status']).to eq('SUCCESS')
        end
      end

      describe 'POST #create' do
        let(:course) { FactoryBot.create(:course) }
        let(:user) { FactoryBot.create(:user) }
        let(:order_attributes) do
          {
            course_id: course.course_id,
            user_name: user.user_name,
            password: user.password
          }
        end
        it 'saves new order' do
          expect do
            post :create, params: order_attributes
          end.to change(Order, :count).by(1)
          json = JSON.parse(response.body)
          expect(json['status']).to eq('SUCCESS')
        end
        it 'should not save with invalid password' do
          order_attributes[:password] << 'a'
          expect do
            post :create, params: order_attributes
          end.to change(Order, :count).by(0)
          json = JSON.parse(response.body)
          expect(json['status']).to eq('ERROR')
        end
      end

      describe 'DELETE #destroy' do
        let(:course) { FactoryBot.create(:course) }
        let(:user) { FactoryBot.create(:user) }
        let(:order_attributes) do
          {
            id: 1,
            course_id: course.course_id,
            user_name: user.user_name,
            password: user.password
          }
        end
        before { post :create, params: order_attributes }
        it 'deletes the course' do
          expect do
            delete :destroy, params: { id: Order.first.id, user_name: user.user_name, password: user.password }
          end.to change(Order, :count).by(-1)
          json = JSON.parse(response.body)
          expect(json['status']).to eq('SUCCESS')
        end
        it 'should not delete with invalid password' do
          expect do
            delete :destroy, params: { id: Order.first.id, user_name: user.user_name, password: user.password + 'a' }
          end.to change(Order, :count).by(0)
          json = JSON.parse(response.body)
          expect(json['status']).to eq('ERROR')
        end
      end

    end
  end
end
