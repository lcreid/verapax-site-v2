# frozen_string_literal: true

require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include SessionTestHelper

  test "show dashboard" do
    user = users(:one)

    sign_in_as(user)
    get dashboard_path
    assert_response :ok
    assert_select "h1", "#{user.name}'s Dashboard"
    assert_select "input[value='Name Contact01']"
    assert_select "input[value='Name Contact02']"
  end
end
