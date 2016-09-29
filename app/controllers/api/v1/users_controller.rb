class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render status: 201, json: user
    else
      render_create_error(user)
    end
  end

  def index
    render json: User.all
  end

  def show
    if User.exists?(params[:id])
      render json: User.find(params[:id])
    else
      render_show_error
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :social_security_number)
  end

  def render_create_error(user)
    render status: 400, json: {
      message: user.errors.full_messages.join(". ")
    }
  end

  def render_show_error
    render status: 404, json: {
      message: "The user you requested could not be found."
    }
  end
end
