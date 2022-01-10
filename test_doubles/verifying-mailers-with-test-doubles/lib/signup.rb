require "account"
require "signup_mailer"
require "user"

class Signup
  def initialize(account_name:, email:, logger:)
    @account_name = account_name
    @email = email
    @logger = logger
  end

  def save
    account = Account.create!(name: @account_name)
    User.create!(account: account, email: @email)
    true
  end
end
