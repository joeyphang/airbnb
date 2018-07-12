class UsersController < Clearance::UsersController

	def new
		@users = User.new
	end

	def create
		p params
		@users = User.new(user_params)
		@users.user_id = current_user.id

		if @users.save
			redirect_to users_path
		else
			redirect_to sign_in_path
		end
	end

	def show
		@users = User.find(params[:id])

	end

	def edit #get
		@users = User.find(params[:id])
	end

	def update #patch

		@users = User.find(params[:id])
		if @users.update(user_avatar)
			redirect_to root_path
		else
			redirect_back
		end
	end

	def destroy
	end

	private

	 def user_params
	 	params.require(:user).permit(:email, :password)
	 end

	 def user_avatar
	 	params.require(:user).permit(:avatar)
	 end

end
