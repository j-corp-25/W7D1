# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  username              :string           not null
#  email                 :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  age                   :integer
#  political_affiliation :string
#
class User < ApplicationRecord
  validates :username, :email,:session_token presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: (mininum: 6), allow_nil: true

  attr_reader :password

  before_validation :ensure_session_token


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    if user && is_password?(password)
      user
    else
      nil
    end
  end

  def is_password?(password)
    password_digest = BCrypt::Password.new(self.password_digest)
    password_object.is_password?(password)
  end




  has_many :chirps,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Chirp,
    dependent: :destroy

  has_many :likes,
    primary_key: :id,
    foreign_key: :liker_id,
    class_name: :Like,
    dependent: :destroy

  has_many :liked_chirps,
    through: :likes,
    source: :chirp


  # # DEMO 1: Finder methods

  # #Get first user record, use first
  # User.first

  # #Get last user record, use last
  # User.last

  # #Find a user that exists by id, use find
  # User.find(10)

  # #Find a user that doesn't exist by id, use find
  # User.find(100)

  # #Find a user by username, use find_by ("awesome_person")
  # User.find_by(username: "awesome_person")
  # User.find_by("username = 'awesome_person'")
  # User.find_by("username = (?)", "awesome_person")
  # User.find_by("username = :username", username: "awesome_person")

  # #Find a user by username that does not exist, use find_by
  # User.find_by(username: 'banana')



  # # DEMO 2: Interactive, Queries with Conditions

  # #Find all users between the ages of 10 and 20 inclusive. Show their username, and political affiliation.
  # # User.where("age BETWEEN 10 AND 20")
  # User.select(:political_affiliation, :username).where(age: 10..20)

  # #Find all users not younger than the age of 11. Use `where.not`
  # User.where.not("age < 11")

  # #Find all political_affiliations of our users
  # User.select(:political_affiliation).group(:political_affiliation)
  # User.select(:political_affiliation).distinct

  # #Find all users who has a political affiliation in this list and order by username in ascending order
  # political_affiliations = ["Ruby", "C++"]
  # User.where(political_affiliation: political_affiliations).order(:username)

  # def self.find_by_age(age)
  #   User.where(age: age)
  # end

end
