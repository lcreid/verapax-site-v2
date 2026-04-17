# frozen_string_literal: true

class TestMailer < ApplicationMailer
  def test(email_address)
    mail subject: "Test send of e-mail", to: email_address
  end
end
