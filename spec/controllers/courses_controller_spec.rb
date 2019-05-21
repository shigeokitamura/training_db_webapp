require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'get #show' do
    it "is valid" do
      course = FactoryBot.create(:course)
      get :show, params: { id: course.course_id }
      expect(response.status).to eq(200)
      expect(response).to render_template :show
    end
  end

  describe 'post #create' do  
    it "saves a new course in the database" do
      expect {
        post :create, params: { course: FactoryBot.attributes_for(:course) }
      }.to change(Course, :count).by(1)
    end
    it "redirects to courses#show" do
      course = FactoryBot.attributes_for(:course)
      post :create, params: { course: course }
      expect(response).to redirect_to course_show_path(id: course[:course_id])
    end
  end

  describe 'post #update' do

  end
end

