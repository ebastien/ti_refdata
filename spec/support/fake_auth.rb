module FakeAuth
  def sign_in(user)
  end
end

RSpec.configure do |config|
  config.include FakeAuth, type: :controller
end
