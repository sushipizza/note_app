class SessionsController < ApplicationController
    def new
    
    end
    
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash.now[:notice] = "Login correct"
            redirect_to notes_path
        else
            flash.now[:notice] = "Uncorrect login details"
           render 'new' 
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:success] = "Successfully logout!"
        redirect_to root_path
    end
    
end