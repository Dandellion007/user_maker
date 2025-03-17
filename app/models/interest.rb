# == Schema Information
#
# Table name: interests
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_interests_on_name  (name) UNIQUE
#

# frozen_string_literal: true

class Interest < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :users
end
