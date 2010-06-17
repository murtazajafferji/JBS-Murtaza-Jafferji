require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  # include movie fixtures from test/fixtures/movies.yml
  fixtures :movies
	
  #checks to see that a movie has these fields and that they're valid
  test "check if has title/image_url/starring/runtime/year" do
    #create a new movie
    movie = Movie.new(:title => "Rush Hour", :image_url =>"rushhour.jpg", :starring => "Jackie Chan, Chris Tucker", :runtime => 97, :year => 1998)
    assert !movie.invalid?
	#check if errors if it's invalid for those parameters listed in ()
	assert !movie.errors.invalid?(:title)
	assert !movie.errors.invalid?(:image_url)
	assert !movie.errors.invalid?(:starring)
	assert !movie.errors.invalid?(:runtime)
	assert !movie.errors.invalid?(:year)
  end
  test "movie title is unique" do
    movie = Movie.new(:title => movies(:one).title)
    assert !movie.save
    assert_equal "has already been taken", movie.errors.on(:title)
  end
end
