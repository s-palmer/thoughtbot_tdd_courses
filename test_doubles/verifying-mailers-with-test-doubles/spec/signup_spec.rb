require "spec_helper"
require "signup"

describe Signup do
  describe "#save" do
    it "creates an account with one user" do
      account = stub_created(Account)
      stub_created(User)
      logger = double("logger")
      signup = Signup.new(
        logger: logger,
        email: "user@example.com",
        account_name: "Example"
      )

      result = signup.save

      expect(Account).to have_received(:create!).with(name: "Example")
      expect(User).to have_received(:create!).
        with(account: account, email: "user@example.com")
      expect(result).to be(true)
    end
  end

  def stub_created(model)
    double(model.name).tap do |instance|
      allow(model).to receive(:create!).and_return(instance)
    end
  end
end
