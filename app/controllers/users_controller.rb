class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
    has_scope :by_id
    def new
      @user = User.new
  end

  def index
      @users = User.all
  end

  def show
    Rails.logger.debug @user.inspect
end

def create

end

def edit
 respond_to do |format|
    format.html
    format.js
end
end

def update

end

def destroy

end


private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
    	if params[:id].present?
    		@user = User.find(params[:id])
    	else
    		@user = current_user
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
    	params.require(:user).permit(:email, :password)
    end
end
