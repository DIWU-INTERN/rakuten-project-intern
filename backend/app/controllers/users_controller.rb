class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      Rails.logger.error("Validation errors: #{@user.errors.full_messages}")
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    Rails.logger.error("Error creating user: #{e.message}")
    render json: { error: 'Internal Server Error' }, status: :internal_server_error
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :gender, :age, :prefecture, :city)
  end
end
