class GroupesController < ApplicationController
	before_action :authenticate_user! , only: [:new,:create, :edit, :update, :destroy]
	before_action :check_groupe!, only: [:show, :edit, :update, :destroy]
	#scopes
	has_scope :available
	has_scope :by_name,:using => :by_name, :type => :hash
	has_scope :by_id

	def new
		@groupe = Groupe.new
		@groupe.membres.build
		@groupe.utilises.build

	end

	def index
	#	@groupes = apply_scopes(@current_scopes).all
	@groupes = Groupe.where(nil)
	filtering_params(params).each do |key, value|
		@groupes = @groupes.public_send(key, value) if value.present?

	end
	Rails.logger.debug @groupes.first.avatar.inspect if @groupes.first.present?
end

def show
	@membres = Membre.where(groupe_id: @groupe.id)
	@d = Demande.by_groupe(@groupe.id).map(&:start_date)
	@datesPrises = []
	@d.each do |da|
		@datesPrises << da.strftime("%d/%m/%Y")
	end

	respond_to do |format|
		format.html
		format.js
	end

	Rails.logger.debug @datesPrises.inspect

end

def getDemandesDates
	demandes_dates = Demande.all(:joins => :groupes, 
		:conditions => ["groupe_id = ?", @groupe.id]).map(&:start_date)
end

def create
	@groupe = Groupe.new(groupe_params)
	@groupe.user_id = current_user.id
	Rails.logger.debug "------- BLEEEh " 
	Rails.logger.debug groupe_params.inspect

	
	@groupe.save
	if @groupe.persisted?
		flash[:notice] = "Votre groupe a bien été créé"
		redirect_to my_groupe_path
	else
		flash[:notice] = "Erreur"
		render :new

	end

	Rails.logger.debug @groupe.errors.full_messages.inspect
end

def edit
	respond_to do |format|
		format.html
		format.js
	end
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
    	params.require(:groupe).permit(:name, :date_de_creation, :genre, :description, :avatar, :avatar_cache, membres_attributes: [:id, :nom, :instrument, :_destroy],utilises_attributes: [:materiel_id, :quantite, :_destroy])
    end

	# A list of the param names that can be used for filtering the Product list
	def filtering_params(params)
		params.slice(:by_name, :by_genre, :date)
	end
end
