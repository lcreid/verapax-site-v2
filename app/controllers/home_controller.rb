# frozen_string_literal: true

class HomeController < ApplicationController
  layout "home"

  allow_unauthenticated_access

  def contact_us
    render locals: { email_help:, start_of_thread: nil }
  end

  def create_contact
    success = verify_recaptcha(action: "send_contact_us", minimum_score: 0.5, secret_key: ENV["RECAPTCHA_SECRET_KEY"])

    @contact = Contact.build(
      params.require(:contact).permit(:name, :email_address, :message, :start_of_thread_id),
    )

    if success && @contact.valid?(:unauthenticated) && @contact.save!
      redirect_to contact_thank_you_path
    else
      Rails.logger.debug("rendering contact_us unprocessable_entity success: #{success}")
      render "contact_us", locals: { email_help:, start_of_thread: nil }, status: :unprocessable_entity
    end
  end

  def email_help
    <<~HELP.squish
      We need your e-mail address to send you our response.
    HELP
  end
end
