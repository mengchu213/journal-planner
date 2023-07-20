class UsersController < ApplicationController

    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:index]


  

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user, notice: "Thanks for signing up!"
        else 
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
       if @user.update(user_params)
        redirect_to @user, notice: "Account successfully updated!"
       else
        render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil
        redirect_to categories_url, status: :see_other, 
        alert: "Account successfully deleted!"
    end




    private

    #authorization for current user and admin can only edit delete the current account
    def require_correct_user
        @user = User.find(params[:id])
        redirect_to categories_url, status: :see_other unless current_user?(@user) || current_user.admin?
    end


    def user_params
        params.require(:user).
        permit(:name, :email, :password, :password_confirmation, :username)
    end

end
