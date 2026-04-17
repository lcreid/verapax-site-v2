  # frozen_string_literal: true

  desc "Send a test e-mail"
  task send: :environment do
    TestMailer.test(ENV.fetch("EMAIL_ADDRESS")).deliver_now
  end
