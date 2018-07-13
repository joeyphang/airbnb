class PaymentsController < ApplicationController

	def new
		@client_token = Braintree::ClientToken.generate

		@reservations = Reservation.find(params[:id])

		## passing the price into payment form
		@listing = @reservations.listing
		@price = @reservations.listing.price
		@total_price = @price * (@reservations.end_date - @reservations.start_date).to_i
	end

	def checkout

		## passing the price into checkout

		@reservations = Reservation.find(params[:id])
		@reservations.user_id = current_user.id
		@listing = @reservations.listing
		@price = @reservations.listing.price
		@total_price = @price * (@reservations.end_date - @reservations.start_date).to_i

		nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

		result = Braintree::Transaction.sale(
	   :amount => @total_price, ##
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	   	:submit_for_settlement => true
	   }
	   )
		if result.success?
			@reservations.update(:payment => true)
			ReservationMailer.reservation_email(current_user.email, @reservations.listing.user.email, @reservations.id).deliver_later


			flash[:success] = "Payment Successful"
			redirect_to reservation_path(@reservations)


		else
			flash[:error] =  "Transaction failed. Please try again."
			redirect_to root_path
		end
		
	end

end
