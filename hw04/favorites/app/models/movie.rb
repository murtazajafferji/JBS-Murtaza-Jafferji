class Movie < ActiveRecord::Base
  validates_presence_of :title, :image_url, :starring
  validates_numericality_of :runtime
  validates_uniqueness_of :title
  validates_format_of :image_url,
    :with => %r{\.(gif|jpg|png)$}i,
    :message => 'must be a URL for GIF, JPG ' +
    'or PNG image.'
  
  validate :runtime_must_be_at_least_a_minute
  protected
    def runtime_must_be_at_least_a_minute
      errors.add(:runtime, 'should be at least 1 minute' ) if runtime.nil? || runtime < 1 
    end
    
    def self.find_movies_in_list
      find(:all, :order => "title" )
    end
    
end
