class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :verify_api_token

  def verify_api_token
    raise ActionController::InvalidAuthenticityToken unless api_token
  end

  private

  def api_token
    ApiKey.find_by(token: request.headers['HTTP-X-API-TOKEN'])
  end
end
