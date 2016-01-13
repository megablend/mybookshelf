class ProductsReview < ActiveRecord::Base
   belongs_to :customer, inverse_of: :products_review
   belongs_to :product, inverse_of: :products_review

   # Named Scopes
   # named_scope :active, :conditions => { :status => true }

   before_save do
     self.status = 0
   end

   # validate form details  
   validates :author, presence: true, length: { minimum: 3, maximum: 25 }
   validates :text, presence: true, length: { minimum: 25, maximum: 1000 }
   validates :product_id, presence: true
   validates :rating, presence: true
   
   class << self
   	 # check for existing reviews
     def check_review(parameters)
	     self.where(parameters)
	 end

	 # get the total number of reviews 
	 def product_reviews(product_id)
        self.where(product_id: product_id, status: true)
	 end
   end
end