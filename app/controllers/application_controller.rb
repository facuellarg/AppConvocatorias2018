class ApplicationController < ActionController::API
	include Knock::Authenticable
	undef_method :current_user
	undef_method :current_admin
end
