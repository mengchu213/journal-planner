class SessionsController < ApplicationController

    def new

    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
        redirect_to user, notice: "Welcome back, #{user.name}!"
        else 
            flash.now[:alert] = "Invalid email/password combination!"
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
    end



end
