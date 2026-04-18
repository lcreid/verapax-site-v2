# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :start_of_thread, class_name: "Contact", optional: true
  has_many :replies, class_name: "Contact", foreign_key: :start_of_thread_id, dependent: :destroy
end
