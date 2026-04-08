class ContactsController < ApplicationController
  def new
    email_help = <<~HELP.squish
      We need your e-mail address to send you our response.
    HELP

    render locals: { email_help: }
  end
end
