class UsersController < ApplicationController

	def edit
	end

	def update
		if current_user.update(user_params)
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
