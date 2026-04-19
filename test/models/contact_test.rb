# frozen_string_literal: true

require "test_helper"

class ContactTest < ActiveSupport::TestCase
  test "can save without name and e-mail" do
    contact = Contact.new
    assert contact.save
  end

  test "invalid without name and e-mail in unauthenticated user context" do
    contact = Contact.new
    refute contact.valid?(:unauthenticated)
  end
end
