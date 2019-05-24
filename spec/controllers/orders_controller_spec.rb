require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'create' do
    it 'should require logged-in user' do
      expect do
        post :create
      end.not_to change(Order, :count)
      expect(response).to redirect_to :login
    end
  end
  
  describe 'destroy' do
    let(:user) { FactoryBot.create(:user) }
    let(:course) { FactoryBot.create(:course) }
    let(:order) { FactoryBot.create(:order) }
    it 'should require logged-in user' do
      expect do
        delete :destroy,  params: { id: course.course_id }
      end.not_to change(Order, :count)
      expect(response).to redirect_to :login
    end
  end

end
