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

      describe 'POST #create' do
        let(:course_attributes) { FactoryBot.attributes_for(:course) }
        it 'saves new course' do
          expect do
            post :create, params: { course: course_attributes }
          end.to change(Course, :count).by(1)
          json = JSON.parse(response.body)
          expect(json['status']).to eq('SUCCESS')
          expect(json['data']['course_id']).to eq(course_attributes[:course_id])
        end
      end

      describe 'PATCH #update' do
        let!(:course) { FactoryBot.create(:course) }
        let(:update_attributes) do
          {
            course_title: "hogehoge",
            topic: "fugafuga",
            day_length: 2,
            price: 100,
            level_id: 2,
            category: "piyopiyo"
          }
        end
        it 'saves updated course' do
          expect do
            patch :update, params: { id: course.course_id, course: update_attributes }
          end.to change(Course, :count).by(0)
        end
        it 'updates updated course' do
          patch :update, params: { id: course.course_id, course: update_attributes }
          course.reload
          expect(course.course_id).to eq course.course_id
          expect(course.course_title).to eq update_attributes[:course_title]
          expect(course.topic).to eq update_attributes[:topic]
          expect(course.day_length).to eq update_attributes[:day_length]
          expect(course.price).to eq update_attributes[:price]
          expect(course.level_id).to eq update_attributes[:level_id]
          expect(course.category).to eq update_attributes[:category]
        end
        it 'should not be changed course_id' do
          update_attributes_with_id = update_attributes
          update_attributes_with_id[:course_id] = 'a-2'
          patch :update, params: { id: course.course_id, course: update_attributes_with_id }
          json = JSON.parse(response.body)
          expect(json['status']).to eq('ERROR')
        end
      end

      describe 'DELETE #destroy' do
        let!(:course) { FactoryBot.create(:course) }
        it 'deletes the course' do
          expect do
            delete :destroy, params: { id: course.course_id }
          end.to change(Course, :count).by(-1)
          json = JSON.parse(response.body)
          expect(json['status']).to eq('SUCCESS')
        end
      end
    end
  end
end
