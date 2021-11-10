class ApplicationController < ActionController::API
  protected

  def render_error status, message
    @error_message = message
    render 'api/error', status: status
  end
end
