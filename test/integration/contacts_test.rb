# frozen_string_literal: true

require "test_helper"

class ContactsTest < ActionDispatch::IntegrationTest
  test "unauthenticated user sends message and privileged user responds" do
    get(contact_us_path)
    assert_response :ok
    post create_contact_path, params: {
      contact: {
        name: "Random",
        email_address: "random@example.com",
        message: "Words.",
      },
    }
    assert_redirected_to(contact_thank_you_path)

    contact = Contact.last

    open_session do |session|
      user = users(:one)
      session.sign_in_as(user)
      session.get(dashboard_path)
      session.assert_response :ok
      session.assert_select("div", "random@example.com")

      session.get(contact_path(contact))
      session.assert_response :ok

      session.get(new_contact_path(params: { start_of_thread_id: contact.id }))
      session.post(
        contacts_path,
        params: {
          contact: {
            name: user.name,
            email_address: user.email_address,
            message: "Words in reply.",
            start_of_thread_id: contact.id.to_s,
          },
        },
      )
      session.assert_redirected_to(contact_path(contact))
      session.follow_redirect!

      session.assert_select("div", /Random, sent/)
      session.assert_select("div", /#{user.name}, sent/)
    end

    assert_equal "Words in reply.", Contact.last.message
  end
end
