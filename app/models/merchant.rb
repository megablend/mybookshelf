class Merchant < ActiveRecord::Base
    belongs_to :state
    belongs_to :local_govt
    attr_accessor :remember_token
	before_save {self.email = self.email.downcase}
	validates :firstname, presence: true, length: {maximum: 32}
	validates :lastname, presence: true, length: {maximum: 32}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

	#ensure a secure passowrd for the system
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
end
