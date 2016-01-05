class TemporaryProductsDescription < ActiveRecord::Base
	attr_accessor :add_merchant_id
	# Before a parameter is saved
	before_save do
    self.ebook_price = self.price if protected_option_selected? && self.ebook_price.blank?
		self.price = self.vat_option_id.to_i == 1 ? add_price_vat_option(self.price) : BigDecimal.new(self.price.to_s)
		self.special_price = (self.vat_option_id.to_i == 1 ? add_price_vat_option(self.special_price) : BigDecimal.new(self.special_price.to_s)) if self.special_price.present? && !self.special_price.blank?
    self.ebook_price = (self.vat_option_id.to_i == 1 ? add_price_vat_option(self.ebook_price) : BigDecimal.new(self.ebook_price.to_s)) if self.ebook_price.present? && !self.ebook_price.blank?
    self.publish_date = DateTime.strptime(self.publish_date.to_s, "%Y-%d-%m").to_formatted_s(:db) if self.publish_date.present? && !self.publish_date.blank?
	end

	before_create :merchant_id


   # validate form parameters
   validates :products_type_id, presence: { message: "wasn't selected" }, length: {maximum: 1}
   validates :author, presence: { message: "can't be blank" }, length: {maximum: 128}
   validates :title, presence: { message: "can't be blank" }, length: {maximum: 128}
   validates :vat_option_id, presence: { message: "wasn't selected" }, length: {maximum: 1}
   validates :price, presence: { message: "can't be blank" }, numericality: { greater_than: 0 }
   validate  :special_price_cannot_be_greater_than_price, if: Proc.new { |a| a.price.present? && a.special_price.present? }
   validates :description, presence: { message: "can't be blank" }, length: {minimum: 20}
   validates :quantity, presence: { message: "can't be blank" }, numericality: { greater_than: 0 }
   validate :select_product_protected_option, if: :protected_option_selected?

   def special_price_cannot_be_greater_than_price
       if self.special_price >= self.price
       	  errors.add(:special_price, "can't be greater than or equal to price")
       end
   end

   def select_product_protected_option
      errors.add(:product_protected, "option not selected!") if self.product_protected.nil?
   end

   def merchant_id
     self[:merchant_id] = add_merchant_id
   end

   private
       # check if the protected option was selected
	   def protected_option_selected?
          return true if self.products_type_id.to_i == 2 || self.products_type_id.to_i == 3
	   end

     def get_five_percent_vat(price)
      BigDecimal.new(price.to_s) * 0.05
     end 


     def add_price_vat_option(price)
         BigDecimal.new(price.to_s) + get_five_percent_vat(price)
     end
end