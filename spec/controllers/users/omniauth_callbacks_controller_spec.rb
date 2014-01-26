require 'spec_helper'

describe Users::OmniauthCallbacksController do

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:pocket]
  end

  describe "#pocket" do

    it "should successfully create a user" do
      expect {
        post :pocket, provider: :pocket
      }.to change{ User.count }.by(1)
    end

    it "should create a new user if no user with uid & provider matching" do
      user = create :user
      post :pocket, provider: :pocket
      expect(assigns(:user).id).not_to eq(user.id)
    end

    it "should not create a new user if existing user with uid & provider matching" do
      user = create(:user, pocket_username: "ju_username", pocket_code: "the-token", provider: "pocket", uid: 'ju_test')
      post :pocket, provider: :pocket
      expect(assigns(:user).id).to eq(user.id)
    end

    it "should redirect the user to the root url" do
      post :pocket, provider: :pocket
      response.should redirect_to root_url
    end

  end
end
