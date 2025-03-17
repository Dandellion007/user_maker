# frozen_string_literal: true

class ApplicationController < ActionController::API
  append_view_path "#{Rails.root}/app/views"
  before_action :set_default_request_format

  def set_default_request_format
    request.format = :json unless params[:format]
  end
end
