require "spec_helper"
require "signup"

describe Signup do
  describe "#save" do
    it "creates an account with one user" do
      account = double("account")
      user = double("user")
      allow(Account).to receive(:create!).and_return(account)
      allow(User).to receive(:create!).and_return(user)

      signup = Signup.new(email: "user@example.com", account_name: "Example")
      result = signup.save

  
      expect(Account).to have_received(:create!).with(name: "Example")
      expect(User).to have_received(:create!).with(email: "user@example.com", account: account)
    end
  end

  describe "#user" do
    it "returns the user created by #save" do
      account = double("account")
      user = double("user")
      allow(Account).to receive(:create!).and_return(account)
      allow(User).to receive(:create!).and_return(user)

      signup = Signup.new(email: "user@example.com", account_name: "Example")
      signup.save

      result = signup.user

      expect(result).to eq user
    end
  end

  # Suggested helper refactoring
  # def spy_on_account
  #   account = double("account")
  #   allow(Account).to receive(:create!).and_return(account)
  #   account
  # end

  # def spy_on_user(user = double("user"))
  #   allow(User).to receive(:create!).and_return(user)
  # end
end

