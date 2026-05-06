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

    success = verify_recaptcha(action: "send_contact_us", minimum_score: 0.5, secret_key: ENV["RECAPTCHA_SECRET_KEY_V3"])
    # success = false # Uncomment to force a test of V2.
    success ||= verify_recaptcha(model: @contact, secret_key: ENV["RECAPTCHA_SECRET_KEY_V2"])

    if success && @contact.valid?(:unauthenticated) && @contact.save!
      ContactUsMailer.with(contact: @contact).forward_contact_us.deliver_later
      redirect_to contact_thank_you_path
    else
      Rails.logger.warn("rendering contact_us unprocessable_entity success: #{success}")
      respond_to do |format|
        format.html do
          render "contact_us", locals: { email_help:, start_of_thread: nil }, status: :unprocessable_entity
        end
        format.turbo_stream do
          render "contact_us", locals: { email_help:, start_of_thread: nil }, status: :unprocessable_entity
        end
      end
    end
  end

  def email_help
    <<~HELP.squish
      We need your e-mail address to send you our response.
    HELP
  end
end
