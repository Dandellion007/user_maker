# frozen_string_literal: true

class CreateSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :skills do |t|
      t.string :name
      t.index :name, unique: true

      t.timestamps
    end

    create_join_table :skills, :users do |t|
      t.index :skill_id
      t.index :user_id
    end
  end
end
