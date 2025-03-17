# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  email       :string           not null
#  age         :integer
#  gender      :integer
#  name        :string
#  surname     :string
#  patronymic  :string
#  nationality :string
#  country     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :age, numericality: { only_integer: true, in: 1..90 }

  enum :gender, %i[male female]

  has_and_belongs_to_many :interests
  has_and_belongs_to_many :skills

  # skil во всех местах я исправил на skill.
  #
  # Альтернативный подход: при определении связи
  # указывать параметр class_name. Он используется, когда
  # название класса/связи не соответствует названию внешнего ключа.

  def user_full_name
    [surname, name, patronymic].compact.join(' ')
  end
end
