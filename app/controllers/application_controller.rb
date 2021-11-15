class ApplicationController < ActionController::API
  rescue_from Exception, with: :rescue_error

  attr_reader :current_user

  protected
  def authenticate_request!
    unless user_id_in_token?
      render_error :unauthorized, "Not authenticated"
      return
    end
    @current_user = User.find(auth_token['user_id'])
  rescue JWT::VerificationError, JWT::DecodeError
    render_error :unauthorized, "Not authenticated"
  end

  def render_error status, message
    @error_message = message
    render 'api/error', status: status
  end

  private
  def http_token
      @http_token = request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
  end

  def auth_token
    @auth_token = JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end

  def rescue_error error
    @error_message = error.message
    render 'api/error', status: :bad_request
  end
end
