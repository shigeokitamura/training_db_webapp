require 'rails_helper'

module Api
  module V1
    RSpec.describe CoursesController, type: :controller do
      describe 'GET #index' do
        before { FactoryBot.create(:course) }
        before { get :index }
        it 'has a 200 status code' do
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'GET #index with parameters' do
        before { FactoryBot.create(:course) }
        params = { keyword: "hoge" }
        before { get :index, params: { get: params } }
        it 'has a 200 status code' do
          expect(response).to have_http_status(:ok)
        end
        it 'has correct json data' do
          json = JSON.parse(response.body)
          expect(json['data'].length).to eq(1)
        end
      end

    end
  end
end
