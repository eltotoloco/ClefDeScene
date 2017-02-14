class PreviewsController < ApplicationController 
  before_action :authenticate_user! , only: [:new,:create, :edit, :update, :destroy]
  before_action :set_type
  before_action :set_preview, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found        

  has_scope :available
  has_scope :by_name,:using => :by_name, :type => :hash
  has_scope :by_id
  require 'benchmark'

  def index 
    @previews = type_class.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @preview = type_class.new
  end

  def edit
  end

  def create
    @preview = Preview.new(preview_params)
    if @preview.save
    #  redirect_to @preview, notice: "#{type} was successfully created."
    else
      Rails.logger.debug @preview.errors.full_messages
    end
  end

  def update
    if @preview.update(preview_params)
      redirect_to @preview, notice: "#{type} was successfully created."
    else
      render action: 'edit'
    end
  end


  def destroy
    @preview.destroy
  end


    # Code hidden for brivety

    private

    def set_type 
     @type = type 
   end

   def type 
    Preview.types.include?(params[:type]) ? params[:type] : "Preview"
  end

  def type_class 
    type.constantize 
  end


  def set_preview
    @preview = type_class.find(params[:id])
  end

  def preview_params
    params.require(:preview).permit(:type,{file: []}, :annonce_id, :annonce_token)

  end

  def record_not_found
    flash[:notice] = "Mauvaise preview"
    redirect_to :action => 'index'
  end


end