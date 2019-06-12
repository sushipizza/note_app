class SessionsController < ApplicationController
    def new
    
    end
    
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash.now[:notice] = "zalogowano poprawnie"
            redirect_to users_path(user)
        else
            flash.now[:notice] = "blad w logowaniu"
           render 'new' 
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:success] = "wylogowano"
        redirect_to root_path
    end
    
end