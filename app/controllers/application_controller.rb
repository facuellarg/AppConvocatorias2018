class ApplicationController < ActionController::Base
	include Knock::Authenticable
	undef_method :current_user
	undef_method :current_admin
end
