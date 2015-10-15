class Merchant < ActiveRecord::Base
    belongs_to :state
    has_one :store, inverse_of: :merchant
    attr_accessor :remember_token

	before_save do 
		self.email = self.email.downcase
		self.password = self.password.strip
	end

	# Validate the form details
	validates :firstname, presence: { message: "Your first name can't be blank"}, length: {maximum: 32}
	validates :lastname, presence: { message: "Your last name can't be blank"}, length: {maximum: 32}
	validates :phone_number, presence: { message: "Your phone number can't be blank"}, length: {maximum: 32}, numericality: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: { message: "Your email address can't be blank"}, length: {maximum: 96}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	validates :address, presence: { message: "Your residential address can't be blank"}, length: {maximum: 128}
	validates :city, presence: { message: "Your city can't be blank"}, length: {maximum: 128}
	validates :landmark, presence: { message: "Landmark can't be blank"}, length: {maximum: 128}
	validates :state_id, presence: {message: "Please select your state"}
	validates_acceptance_of :terms, message: "You must accept our terms and conditions"

	#ensure a secure passowrd for the system
	has_secure_password
	validates :password, length: { minimum: 6,  }

	def complete_registration
       update_attribute(:email_verified, 1)
	end

	# Returns the has digest of the given string
	def self.digest(string)
       cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
       BCrypt::Password.create(string, cost: cost)
	end
end
