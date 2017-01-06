class DashboardsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_dashboard, only: [:show]


  

  def show
    @annonces = current_user.annonces
    Rails.logger
  end
  
  def profil
    Rails.logger.debug current_user.inspect
  end

  def annonces
    @annonces = current_user.annonces
    Rails.logger.debug @annonces.inspect
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @dashboard = Dashboard.new
      @annonces = current_user.annonces

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dashboard_params
      params.fetch(:dashboard, {})
    end
  end
