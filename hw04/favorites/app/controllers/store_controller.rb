class StoreController < ApplicationController
  def index
    @movies = Movie.find_movies_in_list
  end

end
