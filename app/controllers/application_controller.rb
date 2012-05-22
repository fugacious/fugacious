class ApplicationController < ActionController::Base
#  include ::SslRequirement
#  ssl_allowed :all
  protect_from_forgery
  
  rescue_from(ActionController::RoutingError) { render :template => 'layouts/404', :status => 404 }
	rescue_from(ActionController::InvalidAuthenticityToken) { render :template => 'layouts/422', :status => 422}
	rescue_from(ActiveRecord::RecordNotFound) { render :template => 'messages/gone', :status => 404 }
	
	def privacy
	  render :template => 'layouts/privacy'
	end
	
#	def ssl_required?
#    return false if RAILS_ENV == 'test' || RAILS_ENV == 'development'
#    super
#  end
end
