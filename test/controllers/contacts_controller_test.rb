require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "get new" do
    get new_contact_path
    assert_response :ok
  end
end
