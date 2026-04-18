# frozen_string_literal: true

class ContactsController < ApplicationController
  layout "dashboard"

  allow_unauthenticated_access only: [ :create ]

  def create
    start_of_thread_id = params.dig(:contact, :start_of_thread_id)
    # TODO: When someone other than a privileged user can use messages, check that the
    # user has access to the thread. For now, just check presence.
    # Rails could do some of this, but later for that.
    start_of_thread = Contact.find(start_of_thread_id) if start_of_thread_id.present?
    @contact = Contact.create!(
      params.require(:contact).permit(:name, :email_address, :message, :start_of_thread_id),
    )

    if authenticated?
      redirect_to contact_path(start_of_thread || contact)
    else
      redirect_to contact_thank_you_path
    end
  end

  def show
    contact = Contact.find(params[:id])
    render locals: { contact:, start_of_thread: contact.start_of_thread }
  end
end
