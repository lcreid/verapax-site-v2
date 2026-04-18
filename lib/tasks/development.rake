# frozen_string_literal: true

namespace :development do
  namespace :data do
    MESSAGES = [
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
    ]

    desc "Create developer's data"
    task create: :environment do
      ActiveRecord::Base.transaction do
        user = User.find_or_initialize_by(email_address: "firstuser@example.com")
        user.name = "First User"
        user.password_digest = BCrypt::Password.create("password")
        user.save!
        puts "Created user #{user.name}, #{user.email_address}."

        messages = MESSAGES.map do |message|
          contact = Contact.find_or_initialize_by(email_address: message.delete(:email_address))
          contact.assign_attributes(**message)
          contact.save!
          puts "Created message #{contact.id} for #{contact.name}."
          contact
        end

        [
          {
            name: "Admin",
            email_address: "admin@example.com",
            message: "Admin's message should be long enough to wrap around in some views.",
            start_of_thread: messages[2],
          },
          {
            name: messages[2].name,
            email_address: messages[2].email_address,
            message: "Reply 2's message should be long enough to wrap around in some views.",
            start_of_thread: messages[2],
          },
          {
            name: "Admin",
            email_address: "admin@example.com",
            message: "Admin's other message should also be long enough to wrap around in some views.",
            start_of_thread: messages[0],
          },
        ].each do |message|
          contact = Contact.find_or_initialize_by(**message)
          contact.save!
          puts "Created reply #{contact.id} to #{contact.start_of_thread_id} for #{contact.name}."
        end
      end
    end

    desc "Destroy data created by this task (if you haven't changed it)"
    task destroy: :environment do
      ActiveRecord::Base.transaction do
        MESSAGES.each do |message|
          Contact.find_by(**message)&.destroy
        end

        User.find_by(email_address: "firstuser@example.com").destroy!
      end
    end
  end
end
