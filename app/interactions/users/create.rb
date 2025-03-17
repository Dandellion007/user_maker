# frozen_string_literal: true

module Users
  class Create < ActiveInteraction::Base
    hash :params do
      integer :age
      string :name
      string :patronymic
      string :email
      string :nationality
      string :country
      string :gender
      string :surname, default: nil

      array :interests, default: [] do
        string
      end

      string :skills, default: ''
    end

    USER_PARAMS = %i[
      age
      name
      patronymic
      email
      nationality
      country
      gender
      surname
    ].freeze

    def execute
      resource = build_resource
      errors.merge!(resource.errors) unless resource.save

      resource.interest_ids = interest_ids if interest_ids.present?
      resource.skill_ids = skill_ids if skill_ids.present?

      resource
    end

    def build_resource
      User.new(user_params)
    end

    def user_params
      params.slice(*USER_PARAMS)
    end

    def interest_names
      params['interests']
    end

    def interest_ids
      return @interest_ids if defined?(@interest_ids)

      interests = Interest.where(name: interest_names)
      @interest_ids = interests.ids
    end

    def skill_names
      params['skills'].split(',')
    end

    def skill_ids
      return @skill_ids if defined?(@skill_ids)

      skills = Skill.where(name: skill_names)
      @skill_ids = skills.ids
    end
  end
end
