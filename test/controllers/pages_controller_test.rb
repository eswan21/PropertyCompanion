require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should redirect home when not signed in" do
    get root_url
    assert_redirected_to new_user_session_path
  end
end
