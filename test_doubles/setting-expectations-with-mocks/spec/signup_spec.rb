require "spec_helper"
require "signup"

describe Signup do
  describe "#save" do
    it "creates an account with one user" do
      signup = Signup.new(email: "user@example.com", account_name: "Example")

      result = signup.save

      expect(Account.count).to eq(1)
      expect(Account.last.name).to eq("Example")
      expect(User.count).to eq(1)
      expect(User.last.email).to eq("user@example.com")
      expect(User.last.account).to eq(Account.last)
      expect(result).to be(true)
    end
  end

  describe "#user" do
    it "returns the user created by #save" do
      signup = Signup.new(email: "user@example.com", account_name: "Example")
      signup.save

      result = signup.user

      expect(result.email).to eq("user@example.com")
      expect(result.account.name).to eq("Example")
    end
  end
end
