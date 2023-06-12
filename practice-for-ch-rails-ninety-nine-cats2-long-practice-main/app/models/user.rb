class User < ApplicationRecord
    validates_presence_of :username, :session_token, :password_digest
    validates_uniqueness_of :username, scope: [:session_token]

    before_validation :ensure_session_token

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end
end
