class SessionsController < ApplicationController
  # The new action corresponds to the login form. It's empty because it does not need to set up any instance variables.
  def new
  end

  # The create action handles the submission of the login form. 
  # It attempts to find the user by email or username and then verifies the password.
  def create
    # Try to find a user either by email or username
    user = User.find_by(email: params[:email_or_username]) ||
           User.find_by(username: params[:email_or_username])
    
    # If a user is found and the password is correct, it logs in the user and redirects to the intended page (if any) or the user's page.
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to (session[:intended_url] || user), notice: "Welcome back, #{user.name}!"
      session[:intended_url] = nil
    else
      # If the login fails, it sets a flash message and re-renders the login form with an unprocessable entity status.
      flash.now[:alert] = "Invalid email/password combination!"
      render :new, status: :unprocessable_entity
    end
  end

  # The destroy action logs out the current user and redirects to the root page.
  def destroy
    session[:user_id] = nil
    redirect_to root_path, status: :see_other, notice: "You're now signed out!"
  end
end
