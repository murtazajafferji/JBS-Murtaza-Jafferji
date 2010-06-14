class LineItem < ActiveRecord::Base
	belongs_to :info
	belongs_to :movie
	
  def self.from_cart_item(cart_item)
    li = self.new
    li.movie     = cart_item.movie
    li.rating    = cart_item.rating
    li
  end
  
end
