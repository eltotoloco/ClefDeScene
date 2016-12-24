class DemandesController < ApplicationController
  before_action :set_demande, only: [:show, :edit, :update, :destroy]
  has_scope :by_annonce
  has_scope :by_user
  has_scope :statut

  # GET /demandes
  # GET /demandes.json
  def index
    @demandes = Demande.all
  end

  # GET /demandes/1
  # GET /demandes/1.json
  def show
   
  end

  # GET /demandes/new
  def new
    @demande = Demande.new
    Rails.logger.debug "bleh"
  end

  # GET /demandes/1/edit
  def edit
  end

  # POST /demandes
  # POST /demandes.json
  def create
    @demande = Demande.new(demande_params)
    @demande.user_id = current_user.id
    Rails.logger.debug demande_params.inspect
    Rails.logger.debug params.inspect 
    respond_to do |format|
      if @demande.save
        UserMailer.welcome_email(User.by_id(Groupe.by_id(@demande.annonce_id).user_id)).deliver
       format.js {}
       redirect_to controller: 'annonces', action: 'show', id: @demande.annonce_id
      else
        format.html { render :new }
        format.json { render json: @demande.errors, status: :unprocessable_entity }
      end
      Rails.logger.debug @demande.errors.full_messages
    end
  end

  # PATCH/PUT /demandes/1
  # PATCH/PUT /demandes/1.json
  def update
    respond_to do |format|
      if @demande.update(demande_params)
        format.html { redirect_to @demande, notice: 'Demande was successfully updated.' }
        format.json { render :show, status: :ok, location: @demande }
      else
        format.html { render :edit }
        format.json { render json: @demande.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demandes/1
  # DELETE /demandes/1.json
  def destroy
    @demande.destroy
    respond_to do |format|
      format.html { redirect_to demandes_url, notice: 'Demande was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def from_category
    @dates = Demande.select(:start_date).where(:annonce_id => params[:annonce_id])
    @selected = []
    @dates.each do |d| 
      @selected << d.start_date.strftime("%d/%m/%Y")
      @selected.first.gsub('&quot;','"')
    end
    Rails.logger.debug @selected.inspect

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demande
      @demande = Demande.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def demande_params
      params.require(:demande).permit(:user_id, :annonce_id, :start_date, :end_date, :prix, :statut)
    end

    def indexByUser(user_id)

    end

  end
