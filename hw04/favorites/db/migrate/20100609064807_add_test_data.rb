#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---

class AddTestData < ActiveRecord::Migration
  def self.up
    Movie.delete_all

    Movie.create(:title => 'Rush Hour',
    :starring => 
    %{<br />
      Jackie Chan
      <br />
      Chris Tucker},
    :image_url =>   '/images/rushhour.jpg',   
    :year => 1998, 
    :runtime => 97)


    Movie.create(:title => 'The Lion King',
    :starring => 
    %{<br />
      Matthew Broderick (adult Simba)
      <br />
      Jonathan Taylor Thomas (young Simba)
      <br />
      James Earl Jones (Mufasa)},
    :image_url =>   '/images/thelionking.jpg',   
    :year => 1994, 
    :runtime => 89)

    # . . .


    Movie.create(:title => 'Iron Man',
    :starring => 
    %{<br />
      Robert Downey Jr.
      <br />
      Terrence Howard
      <br />
      Jeff Bridges
      <br />
      Gwyneth Paltrow},
    :image_url =>   '/images/ironman.jpg',   
    :year => 2008, 
    :runtime => 126)
    
    Movie.create(:title => 'Transformers',
    :starring => 
    %{<br />
    Shia LaBeouf
    <br />
    Megan Fox},
    :image_url =>   '/images/transformers.jpg',   
    :year => 2007, 
    :runtime => 144)

  end

  def self.down
    Movie.delete_all
  end
end

