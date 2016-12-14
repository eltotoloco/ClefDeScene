class GroupesController < ApplicationController
	before_action :authenticate_user! , only: [:create, :edit, :update, :destroy]
	before_action :check_groupe!, only: [:show, :edit, :update, :destroy]


	def new
		@groupe = Groupe.new
		@groupe.membres.build
		@groupe.utilises.build

	end

	def index
		@groupes = Groupe.search(params[:search])
		Rails.logger.debug @groupes.inspect
		Rails.logger.debug @params.inspect
	end

	def show
		@membres = Membre.where(groupe_id: @groupe.id)
	end

	def getDemandesDates
		demandes_dates = Demande.all(:joins => :groupes, 
			:conditions => ["groupe_id = ?", @groupe.id]).map(&:start_date)
	end

	def create

		@groupe = Groupe.new(groupe_params)
		@groupe.user_id = current_user.id
		Rails.logger.debug @groupe.inspect
		Rails.logger.debug groupe_params[:utilises_attributes].inspect
		@groupe.save
		if @groupe.persisted?
			flash[:notice] = "Votre groupe a bien été créé"
			redirect_to my_groupe_path
		else
			flash[:notice] = "Erreur"

		end

		Rails.logger.debug @groupe.errors.inspect
	end

	def edit

	end

	def update
		if @groupe.update_attributes(groupe_params)
      # Handle a successful update.
  else
  	render 'edit'
  end
end

def destroy
	Groupe.destroy(@groupe.id)
	flash[:notice] = "Votre groupe a bien été supprimmé"
	redirect_to my_profile_path
	
end


private

def check_groupe!
	if user_signed_in? && !params[:id].present?
		@groupe = Groupe.find_by(user_id: current_user.id )
	else
		@groupe = Groupe.find(params[:id])
	end
end

    # Never trust parameters from the scary internet, only allow the white list through.
    def groupe_params
    	params.require(:groupe).permit(:name, :date_de_creation, :genre, :description, membres_attributes: [:id, :nom, :instrument, :_destroy],utilises_attributes: [:materiel_id, :quantite, :_destroy])
    end
end
