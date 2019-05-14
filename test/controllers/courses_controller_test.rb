require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get courses_top_url
    assert_response :success
  end

end
