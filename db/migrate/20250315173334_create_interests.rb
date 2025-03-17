# frozen_string_literal: true

class CreateInterests < ActiveRecord::Migration[8.0]
  def change
    create_table :interests do |t|
      t.string :name
      t.index :name, unique: true

      t.timestamps
    end

    create_join_table :interests, :users do |t|
      t.index :interest_id
      t.index :user_id
    end
  end
end
