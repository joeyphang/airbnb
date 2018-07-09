class ListingsController < ApplicationController

before_action :require_login, only: [:new, :create, :delete] # method

	def new
		@listing = Listing.new
		# imply redirection --- erb "new"
	end

	def create
		@listing = Listing.new(listing_params)
		@listing.user_id = current_user.id

		if @listing.save
			redirect_to root_path
		else
			redirect_to new_listing_path
		end

	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		if @listing.update(listing_params)
			redirect_to root_path
		else
			redirect_to listing_path(@listing)
		end
	end

	def destroy
	end


	private

		def listing_params
			params.require(:listing).permit(:title, :description, :country, :price, :num_of_guest, :num_of_bedroom, :num_of_bath, amenities:[])

		end

	end


