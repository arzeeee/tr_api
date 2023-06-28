# frozen_string_literal: true

class CreateWallet < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.float :balance, null: false, default: 0
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
