class AnnoncesController < ApplicationController 
  before_action :authenticate_user! , only: [:new,:create, :edit, :update, :destroy]
  before_action :set_type
  before_action :set_annonce, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found        

  has_scope :available
  has_scope :by_name,:using => :by_name, :type => :hash
  has_scope :by_id

  def index 
    @annonces = type_class.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def catalogue
    @annonces = type_class.all

    respond_to do |format|
      format.js
    end
  end

  def show
  end

  def new
    @annonce = type_class.new
  end

  def edit
  end

  def create
    @annonce = Annonce.new(annonce_params)
    Rails.logger.debug annonce_params
    if @annonce.save
      redirect_to @annonce, notice: "#{type} was successfully created."
    else
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


  def destroy
    @annonce.destroy
    redirect_to annonces_url
  end


    # Code hidden for brivety

    private

    def set_type 
     @type = type 
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
    params.require(type.underscore.to_sym).permit(:type,:name, :experience, :style, :description, :avatar, :avatar_cache, membres_attributes: [:id, :nom, :instrument, :_destroy],utilises_attributes: [:materiel_id, :quantite, :_destroy])
  end

  def record_not_found
    flash[:notice] = "Mauvaise annonce"
    redirect_to :action => 'index'
  end


end