# frozen_string_literal: true

class ContactsController < ApplicationController
  layout "dashboard", except: [ :new ]
  layout "home", only: [ :new ]

  allow_unauthenticated_access

  before_action only: [ :show ] do
    @contact = Contact.find(params[:id])
  end
  attr_reader :contact

  def create
    @contact = Contact.create(
      params.require(:contact).permit(:name, :email_address, :message),
    )

    if authenticated?
      redirect_to contact_path(contact)
    else
      redirect_to contact_thank_you_path
    end
  end

  def new
    email_help = <<~HELP.squish
      We need your e-mail address to send you our response.
    HELP

    @contact = Contact.new
    render locals: { email_help: }
  end

  def show
    render locals: { contact: }
  end
end
