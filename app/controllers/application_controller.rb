class ApplicationController < ActionController::Base

private
   

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    helper_method :current_user

    def current_user?(user)
        current_user == user
    end

    helper_method :current_user?

    def current_user_admin? 
        current_user && current_user_admin?
    end

    def require_signin
        unless current_user
        session[:intended_url] = request.url
        redirect_to new_session_url, alert: "Please sign in first!"
        end
    end

    def require_admin
        unless current_user.admin?
            redirect_to categories_url, alert: "Unauthorized access!"
        end
    end

end
