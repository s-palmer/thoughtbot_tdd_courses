require "spec_helper"
require "signup"

describe Signup do
  describe "#save" do
    it "creates an account with one user" do
      account = double("account")
      expect(Account).to receive(:create!).with(name: "Example").and_return(account)
      expect(User).to receive(:create!).with(account: account, email: "user@example.com")
      signup = Signup.new(email: "user@example.com", account_name: "Example")
      result = signup.save

      expect(result).to be(true)
    end
  end

  describe "#user" do
    it "returns the user created by #save" do
      account = double("account")
      user = double("user")

      expect(Account).to receive(:create!).with(name: "Example").and_return(account)
      expect(User).to receive(:create!).with(account: account, email: "user@example.com").and_return(user)

      signup = Signup.new(email: "user@example.com", account_name: "Example")
      signup.save

      result = signup.user

      expect(result).to eq(user)
    end
  end
end
