# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    age { Faker::Number.between(from: 1, to: 90) }
    gender { :male }
    name { Faker::Name.first_name }
    surname { Faker::Name.middle_name }
    patronymic { Faker::Name.last_name }
    nationality { Faker::Nation.nationality }
    country { Faker::Address.country }
  end
end
