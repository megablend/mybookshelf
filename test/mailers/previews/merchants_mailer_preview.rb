# Preview all emails at http://localhost:3000/rails/mailers/merchants_mailer
class MerchantsMailerPreview < ActionMailer::Preview

   def registration_email_preview
      MerchantsMailer.registration_email(Merchant.find(15))
   end
end
