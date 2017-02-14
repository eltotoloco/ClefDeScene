class DemandesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_demande, only: [:show, :edit, :update, :destroy, :accept]
  has_scope :by_annonce
  has_scope :from_user
  has_scope :to_user
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
    @demande = Demande.new(demande_params)
  #  @demande.build_payment
  Rails.logger.debug @demande.inspect 
end

  # GET /demandes/1/edit
  def edit
  end

  def test
    Rails.logger.debug params.inspect
    @demande = Demande.new(demande_params) 
    @annonce = Annonce.by_id(params[:demande][:annonce_id])
  end


  # POST /demandes
  # POST /demandes.json
  def create

    @demande = Demande.new(demande_params)  

    @demande.from_user_id = current_user.id
    @demande.to_user_id = Annonce.by_id(@demande.annonce_id).user_id
    token = params[:stripeToken]

    # Create a Customer:
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :source => token,
      )
    @demande.token = customer.id
    Rails.logger.debug params.inspect
    if @demande.save
      @message = Message.new
      @message.from = current_user.id
      @message.to =  @demande.to_user_id
      @message.demande_id = @demande.id
      @message.content = "Test"
      @message.save
      #  Rails.logger.debug User.by_id(Annonce.by_id(@demande.annonce_id).user_id)

      if @message.save
        redirect_to @demande.annonce, notice: 'Demande créée'
      else
        Rails.logger.debug @demande.errors.full_messages 

        render :new 
      end
    else
      Rails.logger.debug @demande.errors.full_messages

      render :new 
    end
  end

  def inbox 
    if params[:type] == "received"
      @demandes = current_user.received_demandes
    else
      @demandes = current_user.sent_demandes
    end

    respond_to do |format|
      format.html {render :index }
      format.js
    end

  end

  def mes_demandes
   if params[:type] == "received"
    @demandes = current_user.received_demandes
  else
    @demandes = current_user.sent_demandes
  end
end

def accept
  Rails.logger.debug params.inspect
  Rails.logger.debug  Demande.statuts.inspect

  respond_to do |format|
    if @demande.update(statut: Demande.statuts[params[:statut]])
      format.html { redirect_to @demande, notice: 'Demande was successfully updated.' }
      format.json { render :show, status: :ok, location: @demande }
    else
      format.html { render :edit }
      format.json { render json: @demande.errors, status: :unprocessable_entity }
    end
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
      params.require(:demande).permit(:annonce_id, :start_date, :end_date,:address, :prix, :statut, :token,  payment_attributes: [:id,:first_name,:last_name,:card_security_code,:credit_card_number,:expiration_month,:expiration_year,:amount])
    end

    def indexByUser(user_id)

    end

  end



