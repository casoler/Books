module BooksHelper

	def page_title
		
		case @choice
			when "mine"
	  			@page_title = "My List of Favorites"
	  		when "others"
				@page_title = "Others' Favorite Books"
	    	else 
	    		@page_title = "All Books"
    	end

		@page_title || "List of Books"
	end
	
end
