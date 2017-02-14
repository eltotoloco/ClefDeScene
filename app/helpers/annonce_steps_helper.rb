module AnnonceStepsHelper
	def sti_annonce_steps_path(type = "annonce", annonce = nil)
		send "#{type.underscore}annonce_step_path", annonce
	end
	def sti_start_new_path(type = "annonce", annonce = nil)
		send "start_new_#{type.underscore}_path", annonce
	end

	def format_sti(action, type, annonce)
		action || annonce ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
	end

	def format_action(action)
		action ? "#{action}_" : ""
	end
end
