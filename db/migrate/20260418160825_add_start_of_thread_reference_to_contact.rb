# frozen_string_literal: true

class AddStartOfThreadReferenceToContact < ActiveRecord::Migration[8.1]
  def change
    add_reference :contacts, :start_of_thread, null: true, foreign_key: { to_table: :contacts }
  end
end
