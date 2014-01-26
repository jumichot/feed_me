require 'spec_helper'

describe User do
  describe "#find_for_pocket_oauth" do
    it "create user with the rights credentials" do
      omniauth_hash = stub(
                        :provider => "pocket",
                        :uid => "ju",
                        :extra => stub(:raw_info => stub(:username => 'ju_user')),
                        :credentials => stub(:token => 'abc123'),
                        :slice => {:provider => "pocket", :uid => "ju"}
                      )

        expect {
          User.find_for_pocket_oauth(omniauth_hash)
        }.to change{ User.count }.by(1)

        expect(User.first.pocket_username).to eq('ju_user')
        expect(User.first.pocket_code).to eq('abc123')
        expect(User.first.provider).to eq('pocket')
        expect(User.first.uid).to eq('ju')
    end
  end
end
