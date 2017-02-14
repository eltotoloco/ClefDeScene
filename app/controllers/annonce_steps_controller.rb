class AnnonceStepsController < ApplicationController
	include Wicked::Wizard
	steps :show_what_you_got,:prepare_yourself

	def show
		@annonce = Annonce.by_id(session[:annonce_id])
		render_wizard
	end

	def update
		@annonce = Annonce.by_id(session[:annonce_id])
		@annonce.update_attributes(params[:annonce]) if params[:annonce].present?
		render_wizard @annonce
	end

	private
	def annonce_step_params
		params.require(:annonce_step).permit(:annonce)
	end

	def redirect_to_finish_wizard(options = nil)
		redirect_to @annonce, notice: "Thank you for signing up."
	end
end
