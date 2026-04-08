# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    user = Current.user
    messages = Contact.order(updated_at: :desc)
    render locals: { user:, messages: }
  end
end
