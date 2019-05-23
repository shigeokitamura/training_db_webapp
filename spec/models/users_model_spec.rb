require 'rails_helper'

RSpec.describe User, type: :model do
  it "should be valid" do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it "should buy and cancel a course" do
    user = FactoryBot.create(:user)
    course = FactoryBot.create(:course)
    expect(user.buying?(course)).to be false
    user.buy(course)
    expect(user.buying?(course)).to be true
    expect(course.buyers.include?(user))
    user.cancel(course)
    expect(user.buying?(course)).to be false
  end
end
