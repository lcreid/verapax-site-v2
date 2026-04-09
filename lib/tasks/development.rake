# frozen_string_literal: true

namespace :development do
  namespace :data do
    desc "Create developer's data"
    task create: :environment do
      ActiveRecord::Base.transaction do
        user = User.find_or_initialize_by(email_address: "firstuser@example.com")
        user.name = "First User"
        user.password_digest = BCrypt::Password.create("password")
        user.save!
        puts "Created user #{user.name}, #{user.email_address}."

        [
          {
            name: "Name 1",
            email_address: "name1@example.com",
            message: "Name 1's message should be long enough to wrap around in some views.",
          },
          {
            name: "Name 2",
            email_address: "name2@example.com",
            message: "Name 2's message should be long enough to wrap around in some views.",
          },
          {
            name: "Name 3",
            email_address: "name3@example.com",
            message: "Name 3's message should be long enough to wrap around in some views.",
          },
      ].each do |message|
          contact = Contact.find_or_initialize_by(email_address: message.delete(:email_address))
          contact.assign_attributes(**message)
          contact.save!
          puts "Created message for #{contact.name}."
        end
      end
    end

    desc "Destroy data created by this task"
    task destroy: :environment do
      User.find_by(email_address: "firstuser@example.com").destroy!
    end
  end
end
