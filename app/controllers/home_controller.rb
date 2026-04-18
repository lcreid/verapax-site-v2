# frozen_string_literal: true

class HomeController < ApplicationController
  layout "home"

  allow_unauthenticated_access

  def contact_us
    email_help = <<~HELP.squish
      We need your e-mail address to send you our response.
    HELP

    render locals: { email_help:, start_of_thread: nil }
  end
end
