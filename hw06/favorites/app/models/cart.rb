class Cart 
  attr_reader :items 
  
  def initialize
    @items = []
  end

  def add_movie(movie)
    current_item = @items.find {|item| item.movie == movie}
    if current_item
      if current_item.rating < 10
        current_item.increment_rating
      end
    else
      current_item = CartItem.new(movie)
	  @items << current_item
	end
	current_item
  end
  
  def total_movies
    @items.size
  end
  
  def total_items
	@items.sum { |item| item.rating }
  end
  
  def down_movie(movie)
    current_item = @items.find {|item| item.movie == movie}
    current_item.decrement_rating
    current_item
  end
  
  def remove_movie(movie)
  	current_item = @items.find {|item| item.movie == movie}
    @items.delete(current_item)
    current_item
  end

  
end
