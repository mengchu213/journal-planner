class HomeController < ApplicationController
    def home
      if current_user
        redirect_to categories_path
      end
    end
  end
  