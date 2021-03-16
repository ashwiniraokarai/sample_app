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
      #explicitly redirect to show page (or rails will look for the corresponding view for user#create which we don't create because pointless)
      #you can do redirect_to @user instead for the "rails" way and let it infer (but less intuitive and blackboxish according to me)
      redirect_to user_path(@user)
    else
      #show the same form (template) again but re-render with failed validations and all inputs pre-entered intact
      #this will show as /users in the url even though the template rendered is that of /users/new
      render 'new'
    end
  end
  
  private
    # to get around dangerous security flaw associated with params[:user] that mass assignment of attributes exposes, control which ones you will permit:
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
