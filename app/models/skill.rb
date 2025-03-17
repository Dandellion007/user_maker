# frozen_string_literal: true

# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_skills_on_name  (name) UNIQUE
#

class Skill < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :users
end
