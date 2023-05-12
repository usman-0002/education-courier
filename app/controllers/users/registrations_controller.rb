# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    @user = User.new
    subscriber_user if params[:email].present? && params[:role] == 'subscriber'
  end

  def create
    super
  end

  def update
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password role])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password role])
  end

  def subscriber_user
    email = params[:email]
    if User.find_by(email: email).present?
      flash[:notice] = 'Thankx for your subscription'
      redirect_to root_path
    else
      flash.now[:alert] = 'You need to sign up before continuing.'
      @user.email = params[:email]
      @user.role = params[:role]
    end
  end
end
