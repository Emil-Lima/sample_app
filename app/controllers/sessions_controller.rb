class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:sesion][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log in user and render user's page
    else
      # Create an error message
      render 'new'
    end
  end

  def destroy
  end
end
