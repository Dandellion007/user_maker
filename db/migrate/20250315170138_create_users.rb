# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.index :email, unique: true
      t.integer :age
      t.integer :gender
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :nationality
      t.string :country

      t.timestamps
    end
  end
end
