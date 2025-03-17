# frozen_string_literal: true

module Skills
  class Create < ActiveInteraction::Base
    string :name

    def execute
      resource = build_resource
      errors.merge!(resource.errors) unless resource.save

      resource
    end

    private

    def build_resource
      Skill.new(name:)
    end
  end
end
