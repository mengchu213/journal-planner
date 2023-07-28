class ApplicationController < ActionController::Base

    private
    
        # This method returns the current user, based on the user ID stored in the session.
        # It uses memoization to store the user object in an instance variable @current_user
        # for future use within the same request, avoiding unnecessary database queries.
        def current_user
            @current_user ||= User.find(session[:user_id]) if session[:user_id]
        end
    
        # helper_method allows the current_user method to be accessible from both
        # controllers and views.
        helper_method :current_user
    
        # This method checks whether a given user is the current user.
        def current_user?(user)
            current_user == user
        end
    
        # helper_method allows the current_user? method to be accessible from both
        # controllers and views.
        helper_method :current_user?
    
        # This method checks if the current user exists and whether they are an admin.
        def current_user_admin?
            current_user && current_user.admin?
        end
    
        # This method requires a user to be signed in. If no user is signed in, it
        # stores the URL the user was trying to access in the session under :intended_url, 
        # and then redirects to the sign in page with an alert.
        def require_signin
            unless current_user
            session[:intended_url] = request.url
            redirect_to new_session_url, alert: "Please sign in first!"
            end
        end
    
        # This method requires the current user to be an admin. If they are not, it 
        # redirects to the categories page with an alert.
        def require_admin
            unless current_user.admin?
                redirect_to categories_url, alert: "Unauthorized access!"
            end
        end
    
    end
    