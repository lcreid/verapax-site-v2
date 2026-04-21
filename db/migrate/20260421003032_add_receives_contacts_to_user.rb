# frozen_string_literal: true

class AddReceivesContactsToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :receives_contacts, :boolean, default: false, null: false
  end
end
