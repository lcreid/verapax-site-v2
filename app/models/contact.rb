# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :previous, class_name: "Contact", optional: true
  has_many :responses, class_name: "Contact", foreign_key: :previous_id
end
