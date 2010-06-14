class CartItem
  attr_reader :movie, :rating
  
  def initialize(movie)
    @movie = movie
    @rating = 1
  end

  def increment_rating
    @rating += 1
  end

  def title
    @movie.title
  end

  def rating
    @rating
  end
  
  def year
    @movie.year
  end
  
  def starring
    @movie.starring
  end
  
  def image_url
    @movie.image_url
  end
  
  def runtime
    @movie.runtime
  end
  
  def decrement_rating
    @rating -= 1 if @rating > 0
  end

  
end