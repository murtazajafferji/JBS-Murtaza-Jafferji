class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
    @time = Time.now
  end

end
