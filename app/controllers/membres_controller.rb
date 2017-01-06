class MembresController < ApplicationController
	before_action :set_membre, only: [:show, :edit, :update, :destroy]

	def new
		@membre = Membre.new
	end

	def index
		@membres = Membre.all
	end

	def show
    end

    def create
        @membre = Membre.new(membre_params)
        @membre.save
        Rails.logger.debug "bleh"
    end

    def edit

    end

    def update
        respond_to do |format|
            if @membre.update(membre_params)
                format.html { redirect_to @membre, notice: 'Dashboard was successfully updated.' }
                format.json { render :show, status: :ok, location: @membre }
        else
            format.html { render :edit }
            format.json { render json: @membre.errors, status: :unprocessable_entity }
        end
    end
end

  # DELETE /membres/1
  # DELETE /membres/1.json
  def destroy
    @membre.destroy
    respond_to do |format|
        format.html { redirect_to membres_url, notice: 'Dashboard was successfully destroyed.' }
      format.json { head :no_content }
  end
end


private
    # Use callbacks to share common setup or constraints between actions.
    def set_membre
    	if params[:id].present?
    		@membre = Membre.find(params[:id])
    	else
    		@membre = current_membre
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membre_params
    	params.require(:membre).permit(:id, :nom, :instrument)
    end
end
