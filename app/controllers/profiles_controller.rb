class ProfilesController < ApplicationController
    before_filter :authenticate_user!

    before_action :set_profile, only: [:show, :edit, :update, :destroy]

    def new
      @user = User.new
  end

  def index
      @users = User.all
  end

  def show
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile

      @user = current_user
      @groupe = Groupe.find_by(user_id: @user.id)
      @demandesUser = Demande.where(user_id: @user.id)
      if(@groupe.present?)
      @demandesGroupe = Demande.where(groupe_id: @groupe.id)
    end

    Rails.logger.debug @demandesGroupe.inspect
    Rails.logger.debug @demandesUser.inspect
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
    	params.require(:user).permit(:email, :password)
    end



end
