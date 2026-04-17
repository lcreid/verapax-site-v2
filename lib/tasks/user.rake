# frozen_string_literal: true

namespace :user do
  desc "Create a user"
  task create: :environment do
    ActiveRecord::Base.transaction do
      password = SecureRandom.alphanumeric(32)
      user = User.create!(
        email_address: ENV["EMAIL_ADDRESS"],
        name: ENV["NAME"],
        password_digest: BCrypt::Password.create(password),
      )
      PasswordsMailer.reset(user).deliver_now
    end
  end

  desc "Resend password reset e-mail"
  task resend_password_reset_email: :environment do
    user = User.find_by!(email_address: ENV["EMAIL_ADDRESS"])
    PasswordsMailer.reset(user).deliver_now
  end

  desc "Disable a user"
  task disable: :environment do
    puts("Not implemented yet.")
    # user = User.find_by!(email_address: ENV["EMAIL_ADDRESS"])
    # user.update!(disabled: true, disabled_at: Time.now)
  end
end
