module ApplicationHelper
	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

	def annonces_types_options
    Annonce.types.map do |k,v| 
      [t(k, scope: :annonces_types), v]
    end
  end
end
