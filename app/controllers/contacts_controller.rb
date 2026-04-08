# frozen_string_literal: true

class ContactsController < ApplicationController
  allow_unauthenticated_access

  def create
    @contact = Contact.create(
      params.require(:contact).permit(:name, :email_address, :message),
    )

    redirect_to contacts_thank_you_path
  end

  def new
    email_help = <<~HELP.squish
      We need your e-mail address to send you our response.
    HELP

    @contact = Contact.new
    render locals: { email_help: }
  end
end
