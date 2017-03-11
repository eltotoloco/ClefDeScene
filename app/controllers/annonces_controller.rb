class AnnoncesController < ApplicationController 
  before_action :authenticate_user! , only: [:new,:create, :edit, :update,:begin,:my_annonces, :destroy]
  before_action :set_type
  before_action :set_annonce, only: [:show, :edit, :update, :destroy]
  before_action :validates_creator , only: [:edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found        

  has_scope :available
  has_scope :by_type
  has_scope :not_booked
  has_scope :booked
  has_scope :by_name,:using => :by_name, :type => :hash
  has_scope :by_id

  require 'benchmark'

  def index 
    @annonces = type_class.all
    Rails.logger.debug @type
    filtering_params(params).each do |key, value|
      @annonces = @annonces.public_send(key, value) if value.present?
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def catalogue
    @annonces = type_class.all
    filtering_params(params).each do |key, value|
      @annonces = @annonces.public_send(key, value) if value.present?

    end
    respond_to do |format|
      format.js
      format.html { 
        if params[:type] == 'Group' 
          redirect_to groups_url 
        elsif params[:type] == 'Photographer'
          redirect_to photographers_url
        else
          redirect_to annonces_url
        end  }
      end
    end

    def show
      @demande = Demande.new
      @datesDispo = []
      @datesPrises = []
      @annonce.demandes.confirmee.each do |demande| 
        @start = demande.start_date.strftime("%d/%m/%Y")
        @end = demande.end_date.strftime("%d/%m/%Y")
        (@start.to_date..@end.to_date).each do |dates|
         @datesPrises << dates.strftime("%d/%m/%Y")
       end    
     end   
     @annonce.availabilities.each do |availability| 
      @start = availability.start_date.strftime("%d/%m/%Y")
      @end = availability.end_date.strftime("%d/%m/%Y")
      (@start.to_date..@end.to_date).each do |dates|
       @datesDispo.push(dates.strftime("%d/%m/%Y"))
     end    
   end   


   Rails.logger.debug @annonce.previews.inspect
   Rails.logger.debug @datesDispo.inspect
 end

 def getBookedDates 
   @annonce.demandes.confirmee.each do |demande| 
    @start = demande.start_date.strftime("%d/%m/%Y")
    @end = demande.end_date.strftime("%d/%m/%Y")
    (@start.to_date..@end.to_date).each do |dates|
     @datesPrises << dates.strftime("%d/%m/%Y")
   end    
 end   

 respond_to do |format|
  format.js
  format.html
end
end

def new
  @annonce = type_class.new
  @annonce.token = Annonce.generate_token
  1.times {@annonce.links.build}
  #1.times {@annonce.previews.build}
  Rails.logger.debug @annonce.avatar.thumb.size.inspect
  respond_to do |format|
      format.html # new.html.erb
      format.json { annonces_url }
    end
  end

  def edit
    1.times {@annonce.links.build}

  end

  def create
    annonce_params['level'] = annonce_params['level'].to_f
    Rails.logger.debug annonce_params['level']
    @annonce = Annonce.new(annonce_params)
    @annonce.user = current_user
   # @previews = Preview.where(:annonce_token => @annonce.token)
    #@annonce.previews << @previews

    if @annonce.save
      Rails.logger.debug @annonce.errors.full_messages
      
      session[:annonce_id] = @annonce.id
      redirect_to @annonce
     # redirect_to annonce_step_path( id: 'show_what_you_got')
   else
    Rails.logger.debug @annonce.errors.full_messages

    render action: 'new'
  end

end

def update
  if @annonce.update(annonce_params)
    redirect_to @annonce, notice: "#{type} was successfully created."
  else
    render action: 'edit'
  end
end

def begin
end

def destroy
  @annonce.destroy
  respond_to do |format|
    format.html { redirect_to my_annonces_path, notice: 'annonce was successfully destroyed.' }
    format.json { head :no_content }
  end
end

def my_annonces
  @annonces = current_user.annonces
end


    # Code hidden for brivety

    private

    def set_type 
     @type = type 
   end

   def validates_creator
     if(@annonce.user_id == current_user.id)
      return true
    else
      redirect_to annonces_path, notice: "Vous n'avez pas publié cette annonce"
      return false
    end 
  end

  def type 
    Annonce.types.include?(params[:type]) ? params[:type] : "Annonce"
  end

  def type_class 
    type.constantize 
  end


  def set_annonce
    @annonce = type_class.find(params[:id])
  end

  def annonce_params
    params.require(type.underscore.to_sym).permit(:type,:name, :experience,:user_id, :level,:price,:avg_time, :style,:token, :description, :avatar, :avatar_cache,:min_days_for_booking,availabilities_attributes: [:id, :start_date, :end_date, :_destroy], membres_attributes: [:id, :nom, :instrument, :_destroy],utilises_attributes: [:materiel_id, :quantite, :_destroy],previews_attributes: [:id, :type, :file, :_destroy],links_attributes: [:id, :url, :site, :_destroy])
  end

  def record_not_found
    flash[:notice] = "Mauvaise annonce"
    redirect_to :action => 'index'
  end

    # A list of the param names that can be used for filtering the Product list
    def filtering_params(params)
      params.slice(:by_name, :by_id,:by_type, :not_booked)
    end


  end