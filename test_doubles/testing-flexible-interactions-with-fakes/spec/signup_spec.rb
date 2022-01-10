require "spec_helper"
require "signup"

describe Signup do
  describe "#save" do
    context "with a valid account and user" do
      it "creates an account with one user" do
        account = stub_valid(Account)
        stub_valid(User)
        logger = stub_logger
        signup = Signup.new(
          logger: logger,
          email: "user@example.com",
          account_name: "Example"
        )

        result = signup.save

        expect(Account).to have_received(:create!).with(name: "Example")
        expect(User).to have_received(:create!).
          with(account: account, email: "user@example.com")
        expect(logger).to have_received(:info).
          with("Created user user@example.com with account Example")
        expect(result).to be(true)
      end
    end

    context "with an invalid account" do
      it "logs an error message" do
        stub_invalid(Account, message: "Name is already taken")
        stub_valid(User)
        logger = stub_logger
        signup = Signup.new(
          logger: logger,
          email: "user@example.com",
          account_name: "Example"
        )

        result = signup.save

        expect(logger).to have_received(:error).with("Name is already taken")
        expect(result).to be(false)
      end
    end

    context "with an invalid user" do
      it "logs an error message" do
        stub_valid(Account)
        stub_invalid(User, message: "Email is already taken")
        logger = stub_logger
        signup = Signup.new(
          logger: logger,
          email: "user@example.com",
          account_name: "Example"
        )

        result = signup.save

        expect(logger).to have_received(:error).with("Email is already taken")
        expect(result).to be(false)
      end
    end
  end

  def stub_valid(model)
    double(model.name).tap do |instance|
      allow(model).to receive(:create!).and_return(instance)
    end
  end

  def stub_invalid(model, message:)
    allow(model).to receive(:create!).and_raise(message)
  end

  def stub_logger
    double("logger").tap do |logger|
      allow(logger).to receive(:debug)
      allow(logger).to receive(:info)
      allow(logger).to receive(:warn)
      allow(logger).to receive(:error)
      allow(logger).to receive(:fatal)
    end
  end
end
