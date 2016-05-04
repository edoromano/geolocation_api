require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }
  subject { @user }
  it { expect respond_to(:email) }
  it { expect respond_to(:password) }
  it { expect respond_to(:password_confirmation) }
  it { expect respond_to(:auth_token) }

  it { expect be_valid }

  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end
end
