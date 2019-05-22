require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #show' do
    let(:course) { FactoryBot.create(:course) }
    before {get :show, params: { id: course.course_id }}

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end
    it 'assigns @course' do
      expect(assigns(:course)).to eq course
    end
    it 'renders the :show template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end
    it 'assigns new @course' do
      expect(assigns(:course)).to be_a_new Course
    end
    it 'renderes the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:course_attributes) { FactoryBot.attributes_for(:course) }

    it 'saves new course' do
      expect do
        post :create, params: { course: course_attributes }
      end.to change(Course, :count).by(1)
    end
    it 'redirects the :show template' do
      post :create, params: { course: course_attributes }
      course = Course.last
      expect(response).to redirect_to(course_show_path(course))
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
      expect(course.course_title).to eq update_attributes[:course_title]
      expect(course.topic).to eq update_attributes[:topic]
      expect(course.day_length).to eq update_attributes[:day_length]
      expect(course.price).to eq update_attributes[:price]
      expect(course.level_id).to eq update_attributes[:level_id]
      expect(course.category).to eq update_attributes[:category]
    end
    it 'redirects the :show template' do
      patch :update, params: { id: course.course_id, course: update_attributes }
      course = Course.last
      expect(response).to redirect_to(course_show_path(course))
    end
  end

  describe 'GET #delete' do
    let(:course) { FactoryBot.create(:course) }
    before {get :delete, params: { id: course.course_id }}

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end
    it 'assigns @course' do
      expect(assigns(:course)).to eq course
    end
    it 'renders the :delete template' do
      expect(response).to render_template :delete
    end
  end

  describe 'DELETE #destroy' do
    let!(:course) { FactoryBot.create(:course) }
    it 'deletes the course' do
      expect do
        delete :destroy, params: { id: course.course_id }
      end.to change(Course, :count).by(-1)
      expect(response).to render_template :deleted
    end
  end
end

