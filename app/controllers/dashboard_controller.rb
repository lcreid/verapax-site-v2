# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    user = Current.user
    messages = Contact.where(start_of_thread: nil).order(updated_at: :desc)
    render locals: { user:, messages: }
  end
end
