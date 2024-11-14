require "test_helper"

class TreeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @family = Family.last
  end
  test "should get index" do
    get "/tree/#{@family.id}"
    assert_response :success
  end
end
