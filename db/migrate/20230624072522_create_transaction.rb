# frozen_string_literal: true

class CreateTransaction < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :note
      t.float :amount, null: false, default: 0
      t.integer :transaction_type
      t.integer :status
      t.date :transaction_date, null: false
      t.references :wallet, foreign_key: true
      t.timestamps
    end
  end
end
