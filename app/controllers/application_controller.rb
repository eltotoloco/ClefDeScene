class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	

	protected


	def after_sign_in_path_for(resource_or_scope)
		if(current_user.sign_in_count ==1)
			welcome_path
		else
			annonces_path
		end
	end
end
