class LinksController < ApplicationController
	before_action :set_link, only: [:show, :edit, :update, :destroy]

	def new
		@link = Link.new
	end

	def index
		@links = Link.all
	end

	def show
	end

	def create
		@link = Link.new(link_params)
		@link.save
	end

	def edit

	end

	def update
		respond_to do |format|
			if @link.update(link_params)
				format.html { redirect_to @link, notice: 'Dashboard was successfully updated.' }
				format.json { render :show, status: :ok, location: @link }
			else
				format.html { render :edit }
				format.json { render json: @link.errors, status: :unprocessable_entity }
			end
		end
	end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
  	@link.destroy
  	respond_to do |format|
  		format.html { redirect_to links_url, notice: 'Dashboard was successfully destroyed.' }
  		format.json { head :no_content }
  	end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
    	if params[:id].present?
    		@link = Link.find(params[:id])
    	else
    		@link = current_link
    	end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
    	params.require(:link).permit(:id, :url, :site)
    end
end
