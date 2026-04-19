# frozen_string_literal: true

class HomeController < ApplicationController
  layout "home"

  allow_unauthenticated_access

  def contact_us
    render locals: { email_help:, start_of_thread: nil }
  end

  def create_contact
    @contact = Contact.build(
      params.require(:contact).permit(:name, :email_address, :message, :start_of_thread_id),
    )

    if @contact.valid?(:unauthenticated) && @contact.save!
      redirect_to contact_thank_you_path
    else
      render "contact_us", locals: { email_help:, start_of_thread: nil }, status: :unprocessable_entity
    end
  end

  def email_help
    <<~HELP.squish
      We need your e-mail address to send you our response.
    HELP
  end
end
