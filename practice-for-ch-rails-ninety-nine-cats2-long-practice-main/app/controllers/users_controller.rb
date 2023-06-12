class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            sign_in!(@user)
            redirect_to users_url
        else
            @users.errors.full_messages status: 422
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end
