class TemporaryProductsDescription < ActiveRecord::Base
	attr_accessor :add_merchant_id
	# Before a parameter is saved
	before_save do
		self.price = self.price.to_f
		self.special_price = self.special_price.to_f if self.special_price.present?
	end

	before_create :merchant_id


   # validate form parameters
   validates :products_type_id, presence: { message: "wasn't selected" }, length: {maximum: 1}
   validates :title, presence: { message: "can't be blank" }, length: {maximum: 128}
   validates :vat_option_id, presence: { message: "wasn't selected" }, length: {maximum: 1}
   validates :price, presence: { message: "can't be blank" }, numericality: { greater_than: 0 }
   validate  :special_price_cannot_be_greater_than_price, if: Proc.new { |a| self.price.present? && a.special_price.present? }
   validates :description, presence: { message: "can't be blank" }, length: {minimum: 20}
   validates :quantity, presence: { message: "can't be blank" }, numericality: { greater_than: 0 }
   validates :product_protected, presence: { message: " - Do you wish to protect this title?" }, if: :protected_option_selected?

   def special_price_cannot_be_greater_than_price
       if self.special_price >= self.price
       	  errors.add(:special_price, "can't be greater than or equal to price")
       end
   end

   def merchant_id
     self[:merchant_id] = add_merchant_id
   end

   private
       # check if the protected option was selected
	   def protected_option_selected?
          return true if self.products_type_id == 2 || self.products_type_id == 3
	  end
end