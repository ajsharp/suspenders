class ActivationsController < ApplicationController

  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?
  end
 
  def create
    @user = User.find(params[:id])
 
    raise Exception if @user.active?
 
    if @user.update_and_activate!(params[:user])
      UserSession.create @user
      @user.deliver_activation_confirmation!
      flash[:success] = "Your account has been activated."
      redirect_to dashboard_path
    else
      render :action => :new
    end
  end

end
