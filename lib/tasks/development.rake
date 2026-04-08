# frozen_string_literal: true

namespace :development do
  namespace :data do
    desc "Create developer's data"
    task create: :environment do
      user = User.create!(
        name: "First User",
        email_address: "firstuser@example.com",
        password_digest: BCrypt::Password.create("password"),
      )
      puts "Created user #{user.name}, #{user.email_address}."
    end
  end
end
