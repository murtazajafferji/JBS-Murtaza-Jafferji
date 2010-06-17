require 'test_helper'
require 'performance_test_help'

# Profiling results for each test method are written to tmp/performance.
class MovieTest < ActionController::PerformanceTest
  def test_index
    get '/movies'
  end
  
  def test_movie
    get '/movies/3'
  end
end
