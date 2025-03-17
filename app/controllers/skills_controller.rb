# frozen_string_literal: true

class SkillsController < ApplicationController
  before_action :set_resource, only: %i[show destroy]

  def index
    @resources = Skill.all
  end

  def show; end

  def create
    outcome = Skills::Create.run(skill_params)

    if outcome.valid?
      @resource = outcome.result
      render(:show)
    else
      render json: outcome.errors.messages, status: :bad_request
    end
  end

  def destroy
    @resource.destroy!
  end

  private

  def set_resource
    @resource = Skill.find(params[:id])
  end

  def skill_params
    params.permit(:name)
  end
end
