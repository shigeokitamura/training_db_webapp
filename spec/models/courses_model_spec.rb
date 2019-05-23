require 'rails_helper'

RSpec.describe Course, type: :model do
  it "is valid" do
    course = FactoryBot.create(:course)
    expect(course).to be_valid
  end
end
