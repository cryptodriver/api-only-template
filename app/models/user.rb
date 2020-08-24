class User < ApplicationRecord
  has_secure_password
  has_secure_token

  has_one :relation
  has_one :profile

  def self.valid_signin?(email, password)
    user = find_by(email: email)
    if user && user.authenticate(password)
      user
    end
  end

  def allow_token_to_be_used_only_once
    regenerate_token
    touch(:token_sent_at)
  end

  def signout
    invalidate_token
  end

  def with_unexpired_token(token, period)
    where(token: token).where('token_sent_at >= ?', period).first
  end

  private

  def invalidate_token
    update_columns(token: nil)
    touch(:token_sent_at)
  end
end
