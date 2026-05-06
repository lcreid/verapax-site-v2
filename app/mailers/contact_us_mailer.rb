# frozen_string_literal: true

class ContactUsMailer < ApplicationMailer
  def forward_contact_us
    @contact = params[:contact]
    recipients = User.where(receives_contacts: true)
    raise ArgumentError, "No recipients for Contact Us messages." if recipients.empty?

    headers({
      reply_to: email_address_with_name(@contact.email_address, @contact.name),
    })
    mail(to: recipients.map(&:email_address), subject: "Message from Contact Us")
  end
end
