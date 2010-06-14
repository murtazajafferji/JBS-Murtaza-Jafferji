class StoreController < ApplicationController
  def index
    @movies = Movie.find_movies_in_list
    @cart = find_cart
  end
  
  def add_to_cart
    movie = Movie.find(params[:id])
    @cart = find_cart
    @current_item = @cart.add_movie(movie)
    if params[:id] != "3"
      respond_to do |format|
	    format.js if request.xhr?
		format.html {redirect_to_index}
	  end
	end
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid movie #{params[:id]}" )
	redirect_to_index("Invalid movie" )
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to_index
  end
  
  def down_from_cart
  	begin
      movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid movie #{params[:id]}")
      redirect_to_index("Invalid movie" )
    else
      @cart = find_cart
      @current_item = @cart.down_movie(movie)
      respond_to do |format|
	    format.js if request.xhr?
		format.html {redirect_to_index}
	  end
    end
  end
  
  def remove_from_cart
  	begin
      movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid movie #{params[:id]}")
      redirect_to_index("Invalid movie" )
    else
      @cart = find_cart
      @current_item = @cart.remove_movie(movie)
      respond_to do |format|
	    format.js if request.xhr?
		format.html {redirect_to_index}
	  end
    end
  end

  def back_to_index
    redirect_to :action => 'index'
  end
  
  def order_list
	@cart = find_cart
	if @cart.items.empty?
	  redirect_to_index("Your cart is empty" )
	else
	  @info = Info.new
	end
  end
  
  def save_list
    @cart = find_cart
    @info = Info.new(params[:info]) 
    @info.add_line_items_from_cart(@cart) 
    if @info.save                     
      #session[:cart] = nil
      redirect_to_index("You have successfully saved your list!")
    else
      render :action => 'order_list'
    end
  end
  
  
private

  def find_cart
    session[:cart] ||= Cart.new
  end
    
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => 'index'
  end

end
