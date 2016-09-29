class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render status: 201, json: user
    else
      render_error(user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :social_security_number)
  end

  def render_error(user)
    render status: 400, json: {
      message: user.errors.full_messages.join(". ")
    }
  end
end
