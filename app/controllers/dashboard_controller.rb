# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    user = Current.user
    render locals: { user: }
  end
end
