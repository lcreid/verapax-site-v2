# frozen_string_literal: true

class HomeController < ApplicationController
  layout "home"

  allow_unauthenticated_access

  def contact_us
    email_help = <<~HELP.squish
      We need your e-mail address to send you our response.
    HELP

    @contact = Contact.new

    render locals: { email_help:, previous: nil }
  end
end
