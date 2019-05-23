require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:course) { FactoryBot.create(:course) }
  let(:order) { Order.new(buyer_id: user.id, bought_id: course.course_id) }
  
  it "should be valid" do
    expect(order).to be_valid
  end

  it "should require a buyer_id" do
    order.buyer_id = nil
    expect(order).not_to be_valid 
  end

  it "should require a bought_id" do
    order.bought_id = nil
    expect(order).not_to be_valid
  end
end
