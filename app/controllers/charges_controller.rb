class ChargesController < ApplicationController
	def new
	end

	def show
		 @amount = 500
	  customer = Stripe::Customer.create(
	  	:email => "tpa.lopes@gmail.com",
	  	:source  => "tok_19i4rbCxymApZMi8lVvlPNJT"
	  	)

	  charge = Stripe::Charge.create(
	  	:customer    => customer.id,
	  	:amount      => @amount,
	  	:metadata => {"demande_id" => 6735},
	  	:description => 'Rails Stripe customer',
	  	:currency    => 'usd'
	  	)
 	Rails.logger.debug charge.inspect
 			redirect_to new_charge_path

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to new_charge_path
	end


def create
	  # Amount in cents
	  @amount = 500
	  customer = Stripe::Customer.create(
	  	:email => params[:stripeEmail],
	  	:source  => params[:stripeToken]
	  	)

	  charge = Stripe::Charge.create(
	  	:customer    => customer.id,
	  	:amount      => @amount,
	  	:metadata => {"demande_id" => 6735},
	  	:description => 'Rails Stripe customer',
	  	:currency    => 'usd'
	  	)

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to new_charge_path
	end
end
