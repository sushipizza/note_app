class UsersController < ApplicationController
   before_action :set_user, only: [:edit, :update, :show]
   before_action :require_same_user, only: [:edit, :update, :destroy]
   
   def index
      @users = User.all
   end
   
   def new
       @user = User.new
   end
   
   def create
      @user = User.new(user_params)
       if @user.save
           flash[:notice] = "User created"
           redirect_to user_path(@user)
       else
           render 'new'
       end
   end
   
   def edit

   end
   
   def update
      if @user.update(user_params)
         flash[:notice] = "User details updated"
         redirect_to notes_path
      else
         render 'edit'
      end
   end
   
   def show

   end
   
   def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:danger] = "User deleted"
      redirect_to users_path
   end
   
   private 
   def user_params
      params.require(:user).permit(:username, :email, :password) 
   end
   
   def set_user
      @user = User.find(params[:id])
   end
   
   def require_same_user
      if current_user != @user and !current_user.admin?
         flash[:danger] = "Nie twoje konto"
         redirect_to root_path
      end
   end
end