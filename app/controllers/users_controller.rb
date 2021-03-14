class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      #show page with the new user created
    else
      #show the same form but re-render with failed validations and all inputs pre-entered intact
      render 'new'
    end
  end
  
  private
    # to get around dangerous security flaw associated with params[:user] that mass assignment of attributes exposes, control which ones you will permit:
    def user_params
      params.require(:user).permit(:name, :emai, :password, :password_confirmation)
    end
end
