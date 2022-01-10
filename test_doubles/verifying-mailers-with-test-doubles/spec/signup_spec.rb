require "spec_helper"
require "signup"
require_relative "./support/fake_logger"

describe Signup do
  describe "#save" do
    it "creates an account with one user" do
      account = stub_created(Account)
      user = stub_created(User)
      logger = FakeLogger.new
      mailer = double("mailer", subject: "Example subject")
      allow(mailer).to receive(:deliver)
      allow(SignupMailer).to receive(:signup).with(account: account, user: user).and_return(mailer)

      signup = Signup.new(
        logger: logger,
        email: "user@example.com",
        account_name: "Example"
      )

      result = signup.save

      expect(Account).to have_received(:create!).with(name: "Example")
      expect(User).to have_received(:create!).
        with(account: account, email: "user@example.com")
      expect(mailer).to have_received(:deliver)
      expect(logger.messages[:info].first).to eq("Delivered message: Example subject")
      expect(result).to be(true)
    end
  end

  def stub_created(model)
    double(model.name).tap do |instance|
      allow(model).to receive(:create!).and_return(instance)
    end
  end
end



# Next, use TDD and test doubles to verify that Signup#save writes an info level message to the log after delivering the mailer. The logged message should include the subject from the delivered mailer. Consider whether to use stubs, mocks, spies, fakes, or some combination of several.