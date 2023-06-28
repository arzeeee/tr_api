# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :current_token
      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
