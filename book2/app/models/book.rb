class Book < ActiveRecord::Base
	
	has_and_belongs_to_many :users
	belongs_to :category
	
	validates_presence_of :title, :author_first, :author_last, :publish_year, :category_id
	validates_uniqueness_of :title
	validates_numericality_of :publish_year
	
	cattr_reader :per_page
	@@per_page = 2
	
end
