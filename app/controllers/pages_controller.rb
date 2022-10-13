class PagesController < ApplicationController
    def home
        # render html: "hello world"
        redirect_to articles_path if logged_in?
    end
    
    def about
    end
end
