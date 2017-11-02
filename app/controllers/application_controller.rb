class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from(ActionController::RoutingError) { render template: 'layouts/404', status: 404 }
  rescue_from(ActionController::InvalidAuthenticityToken) { render template: 'shared/422', status: 422}
  rescue_from(ActiveRecord::RecordNotFound) { render template: 'messages/gone', status: 404 }
end
