class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    username = params[:user]

end
