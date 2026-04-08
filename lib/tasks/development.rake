# frozen_string_literal: true

namespace :development do
  namespace :data do
    desc "Create developer's data"
    task create: :environment do
      ActiveRecord::Base.transaction do
        user = User.create_or_find_by!(email_address: "firstuser@example.com") do |user|
          user.name = "First User"
          user.password_digest = BCrypt::Password.create("password")
        end
        puts "Created user #{user.name}, #{user.email_address}."

        [
          { name: "Name 1", email_address: "name1@example.com", message: "Name 1's message." },
          { name: "Name 2", email_address: "name2@example.com", message: "Name 2's message." },
          { name: "Name 3", email_address: "name3@example.com", message: "Name 3's message." },
      ].each do |message|
          message = Contact.find_or_create_by!(**message)
          puts "Created message from #{message[:name]}."
        end
      end
    end

    desc "Destroy data created by this task"
    task destroy: :environment do
      User.find_by(email_address: "firstuser@example.com").destroy!
    end
  end
end
