class FrontendPagesController < ApplicationController
  def index
     @trending_products = Product.all
  	 render layout: "frontend/index_page_layout"
  end

 # sell on MyBookshelf
  def sell
     
  end

  # checkout page
  def checkout
    render plain: "This is the checkout page"
  end

  # bolg page
  def blog

  end

  # company terms of service
  def terms

  end

  # product page
  def product
    @product_details = ProductsDescription.where(slug: params[:product_title])
    @product = Product.find(@product_details.first.product_id.to_i)
  end

  # product review
  def review
     @review = ProductsReview.new(validate_product_review)

     # check if this review has previously been added to the platform 
     if ProductsReview.check_review(validate_product_review).size > 0
       @duplicate = true
     else
       if !@review.save
          @error = true
       end
     end

     respond_to do|format|
        format.html
        format.js
     end
  end

  private 
    def validate_product_review
      params.require(:product_review).permit(:author, :product_id, :text, :rating)
    end
  
end
