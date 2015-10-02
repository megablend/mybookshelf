class MerchantsMailer < ApplicationMailer
	default from: "\"MyBookshelf\" <no-reply@mybookshelf.com.ng>"

	def registration_email(merchant)
       @merchant = merchant
       mail(to: @merchant.email, "Merchant Registration - Email Verification")
	end
end
