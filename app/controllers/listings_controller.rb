class ListingsController < ApplicationController

	before_action :require_login, only: [:new, :create, :delete] # method
	before_action :check_update_rights, only: [:edit, :update]
	## only moderator can verify
	before_action :check_verification_rights, only: [:verify]

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

	def show
		@listing = Listing.find(params[:id])
		
	end

	def edit  ## only current_user || admin can edit
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

	def verify
		@listing = Listing.find(params[:id])

		if @listing.verified == true
			@listing.update(verified: false)
		else
			@listing.update(verified: true)
		end

		if @listing.save
			redirect_to listing_path(@listing)
		end
	end


	private

		def listing_params
			params.require(:listing).permit(:title, :description, :country, :price, :num_of_guest, :num_of_bedroom, :num_of_bath, {amenities:[]}, {avatar: []})

		end

		def check_update_rights
			@listing = Listing.find(params[:id])
			if current_user.id != @listing.user_id && !current_user.admin?
				redirect_to root_path
			end
		end

		def check_verification_rights
			if !current_user.moderator?
			flash[:error] = "Access Denied"
				redirect_to root_path
			end
		end

	end


