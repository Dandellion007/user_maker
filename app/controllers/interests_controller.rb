# frozen_string_literal: true

class InterestsController < ApplicationController
  before_action :set_resource, only: %i[show destroy]

  def index
    @resources = Interest.all
  end

  def show; end

  def create
    outcome = Interests::Create.run(interest_params)

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
    @resource = Interest.find(params[:id])
  end

  def interest_params
    params.permit(:name)
  end
end
