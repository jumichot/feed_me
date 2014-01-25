require 'pocket'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def pocket
    @user = User.find_for_pocket_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect(@user)
      set_flash_message(:notice, :success, :kind => "Pocket") if is_navigational_format?
    else
      session["devise.pocket_data"] = request.env["omniauth.auth"]
      return redirect_to root_path
    end
  end
end
