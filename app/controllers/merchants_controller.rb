class MerchantsController < ApplicationController
  
  # dashboard
  def index

  end
   
  # signup page 
  def new
  	 @merchant = Merchant.new
  end
end
