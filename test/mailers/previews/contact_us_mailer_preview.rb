# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/contact_us_mailer
class ContactUsMailerPreview < ActionMailer::Preview
  def forward_contact_us
    contact = Contact.last
    ContactUsMailer.with(contact:).forward_contact_us
  end
end
