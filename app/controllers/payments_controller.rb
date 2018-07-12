class PaymentsController < ApplicationController

	def new
		@client_token = Braintree::ClientToken.generate

		@reservations = Reservation.find(params[:id])
	end

	def checkout
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

	  result = Braintree::Transaction.sale(
	   :amount => "10.00", #this is currently hardcoded
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	      :submit_for_settlement => true
	    }
	   )

	  if result.success?
	  	redirect_to root_path 
		flash[:success] = "Payment Successful"
	  else
	  	redirect_to root_path
		flash[:error] =  "Transaction failed. Please try again."
	  end
	end

end
