class RegistrationsController < Devise::RegistrationsController

  private
    def sign_up_params
      params.require(:user).permit(:email, :password, :major, :college, :year, :password_confirmation)
    end
end