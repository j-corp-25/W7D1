class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        @current_user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        # user_params[:username], user_params[:password] #does this work?
        sessions[:session_token] = @current_user.reset_session_token!
        redirect_to cats_url
    end

    # private #can we/should we use this?
    # def user_params
    #     params.require(:user).permit(:username, :password)
    #     [user[:username] = bob, user[:password] = password]
    # end
end