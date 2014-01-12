require 'pocket'
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def pocket
    # handle callback from Pocket here !
  end
end
