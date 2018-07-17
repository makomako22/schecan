class UsersController < ApplicationController
 	before_action :edit_password , except: [:edit, :update]
	def edit
	end

	def update
		if current_user.update(user_params)
			user = current_user
			if user.sign_in_count == 1 
				user.sign_in_count = 2
				user.save
			end
			redirect_to root_path, notice: "パスワードが変更されました"
    else
      flash.now[:alert] = "必須項目が入力されていません"
      render :edit
    end
	end
      
	private

	def user_params
		params.require(:user).permit(:password, :password_confirmation)
	end

end
