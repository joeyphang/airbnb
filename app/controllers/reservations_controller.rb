class ReservationsController < ApplicationController

	def index

	end

	def new
		@reservations = Reservation.new
		@listing = Listing.find(params[:listing_id])
	end

	def create
		@reservations = Reservation.new(reservation_params)
		@listing = Listing.find(params[:listing_id])
		@reservations.listing_id = params[:listing_id]
		@reservations.user_id = current_user.id

		if @reservations.save
			redirect_to root_path 
			flash[:notice] = "Reservation Successful"
		else
			redirect_to listing_path(@listing)
			flash[:error] =  "#{@reservations.errors.full_messages}"
		end
	end

	def show
		@reservations = Reservation.find(params[:id])
		@listing = Listing.find(params[:listing_id])
		@reservations.listing_id = params[:listing_id]
		@reservations.user_id = current_user.id

	end

	def edit
	end

	def update
		@reservations = Reservation.find(params[:id])
		if @reservations.update(reservation_params)
			redirect_to root_path
		else
			redirect_to listing_path(@listing)
		end
	end

	def destroy
	end


	private
		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date, :price, :total, :user_id, :listing_id)

		end
end
