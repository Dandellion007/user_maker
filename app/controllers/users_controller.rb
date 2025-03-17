# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_resource, only: %i[show destroy]

  def index
    @resources = User.includes(:skills, :interests).all
  end

  def show; end

  def create
    outcome = Users::Create.run(user_params)

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
    @resource = User.find(params[:id])
  end

  def user_params
    params.permit(params: {})
  end
end
