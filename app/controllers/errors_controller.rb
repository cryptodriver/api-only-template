class ErrorsController < ActionController::Base
  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def catch_all 
    render json: {},  status: 200
  end
end
