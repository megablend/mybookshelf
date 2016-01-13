class MerchantsMailer < ApplicationMailer
	include ApplicationHelper # mix merchants helper
	default from: "\"MyBookshelf\" <no-reply@mybookshelf.ng>"

	def registration_email(merchant)
       @merchant = merchant # get merchant details
       @company_profile = CompanyProfile.find(1) # get comapny details
       @full_name = capitalize_string(@merchant.firstname) + " " + capitalize_string(@merchant.lastname)
       @domain = @company_profile.domain_name

       #footer links
       @footer_links = { about_us: "#{@domain}/about-us",
                         faq: "#{@domain}/merchants/faq" }

       recipient_email_and_name = %("#{@full_name}" <#{@merchant.email}>) # recipient email and name
       subject = "Merchant Registration - Email Verification"
       mail(to: recipient_email_and_name, subject: subject)
	end
end
