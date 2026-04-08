require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "get new" do
    get new_contact_path
    assert_response :ok
  end

  test "post create" do
    post contacts_path, params: { contact: { name: "Name", email_address: "email@example.com", message: "Message" } }
    assert_redirected_to contacts_thank_you_path
  end
end
