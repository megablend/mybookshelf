class Merchant < ActiveRecord::Base
    belongs_to :state
    attr_accessor :remember_token
	before_save {self.email = self.email.downcase}

	# Validate the form details
	validates :firstname, presence: true, length: {maximum: 32}
	validates :lastname, presence: true, length: {maximum: 32}
	validates :phone_number, presence: true, length: {maximum: 32}, numericality: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	validates_acceptance_of :terms

	#ensure a secure passowrd for the system
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
end
