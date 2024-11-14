require "test_helper"

class TreeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @family = Family.last
  end
  test "should show tree" do
    get "/trees/#{@family.id}"
    assert_response :success
  end
end
