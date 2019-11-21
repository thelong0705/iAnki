require 'test_helper'

class HomePagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get home_pages_show_url
    assert_response :success
  end

end
