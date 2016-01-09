class FrontendPagesController < ApplicationController
  def index
     @trending_products = Product.all
  	 render layout: "frontend/index_page_layout"
  end

 # sell on MyBookshelf
  def sell
     
  end

  # bolg page
  def blog

  end

  # company terms of service
  def terms

  end

  # test a new design
  def product
    @product_details = ProductsDescription.where(slug: params[:product_title])
    @product = Product.find(@product_details.first.product_id.to_i)
  end
  
end
