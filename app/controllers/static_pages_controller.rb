class StaticPagesController < ApplicationController
	def home
	end

	def help
		@preview = Preview.new
	end

	def about
	end

	def inscription
	end

	def welcome
		@previews = Preview.all
	end


	def annonce
	end
end
