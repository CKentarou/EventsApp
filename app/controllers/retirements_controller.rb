class RetirementsController < ApplicationController
  def new
    @user = current_user
  end

  def create
    @user = current_user
    if @user.destroy
      reset_session
      redirect_to root_path, notice: '退会しました'
    else
      redirect_to root_path, alert: @user.errors.full_messages.join(', ')
    end
  end
end
