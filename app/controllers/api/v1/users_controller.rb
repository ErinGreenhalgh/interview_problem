class Api::V1::UsersController < ApplicationController
  def create
    render json: User.create(user_params)
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :social_security_number)
  end
end
