# frozen_string_literal: true

class ContactUsMailer < ApplicationMailer
  def forward_contact_us
    @contact = params[:contact]
    recipient = ENV.fetch("CONTACT_US_EMAIL_ADDRESS", "info@verapax.org")

    headers({
      reply_to: email_address_with_name(@contact.email_address, @contact.name),
    })
    mail(to: recipient, subject: "Message from Contact Us")
  end
end
