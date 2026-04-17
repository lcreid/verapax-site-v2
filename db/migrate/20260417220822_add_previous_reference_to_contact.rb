# frozen_string_literal: true

class AddPreviousReferenceToContact < ActiveRecord::Migration[8.1]
  def change
    add_reference :contacts, :previous, null: true, foreign_key: { to_table: :contacts }
  end
end
