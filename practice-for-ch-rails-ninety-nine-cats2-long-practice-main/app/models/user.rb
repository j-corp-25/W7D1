class User < ApplicationRecord
    validates_presence_of :username, :session_token, :password_digest
    validates_uniqueness_of :username, scope: [:session_token]

    before_validation :ensure_session_token

    attr_reader :password

    def self.find_by_credentials(username,password)
        user = User.find_by(username: username)

        return nil if user.nil?

        user.is_password?(password) ? user : nil

    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def generate_unique_session_token
        SecureRandom.urlsafe_base64(64)
    end

    def ensure_session_token
       self.session_token ||= generate_unique_session_token
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token
    end


end
