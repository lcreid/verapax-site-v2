# frozen_string_literal: true

require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "get contact page" do
    get contact_us_path
    assert_response :ok
  end

  test "post create" do
    post contacts_path, params: { contact: { name: "Name", email_address: "email@example.com", message: "Message" } }
    assert_redirected_to contact_thank_you_path
  end
end
