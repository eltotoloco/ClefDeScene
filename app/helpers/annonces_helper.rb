module AnnoncesHelper

	def sti_annonce_path(type = "annonce", annonce = nil, action = nil)
		send "#{format_sti(action, type, annonce)}_path", annonce
	end

	def format_sti(action, type, annonce)
		action || annonce ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
	end

	def format_action(action)
		action ? "#{action}_" : ""
	end
end