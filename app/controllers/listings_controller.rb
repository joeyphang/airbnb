class ListingsController < ApplicationController

	before_action :require_login, only: [:new, :create, :delete] # method
	before_action :check_update_rights, only: [:edit, :update]
	## only moderator can verify
	before_action :check_verification_rights, only: [:verify]

	def index
		@listing = Listing.all
		@listing = @listing.page(params[:page]).per(9)
	end

	def new
		@listing = Listing.new
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

	def search
		@listing = Listing.all
        @listing = Listing.page(params[:page]).per(4)
        @listing = @listing.price_range(params[:from],params[:to]) if params[:from].present? || params[:to].present?
        filtering_params(params).each do |key, value|
        @listing = @listing.public_send(key, value) if value.present?
          end

          respond_to do |format|
              format.html
              format.js { render :layout => false }
              format.json { render json: @listing }
          end    

        # @listing = @listing.city(params[:city]) if params[:city].present?

		
		# @listing = Listing.where(nil)
		# @listing = @listing.country_search(params[:country_search]) if params[:country_search].present?

		# render 'search'
		
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

		def filtering_params(params)
			params.slice(:country, :title, :num_of_guest, :num_of_bedroom)
		end

	end


