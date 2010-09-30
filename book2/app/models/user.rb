class User < ActiveRecord::Base
	
	has_and_belongs_to_many :books
	
	validates_presence_of :username, :password, :first_name
	validates_uniqueness_of :username
	
	def favorite_added(book)
		if !favorite_exists?(book)
			books << book
		end
	end
	
	def favorite_deleted(book)
		if favorite_exists?(book)
			books.delete(book)
		end
	end
	
	def favorite_exists?(book)
	  if books.exists?(book)
		true
	  else
		false
	  end
	end
	
	
	
	def self.authenticate(username, password)
      user = self.find_by_username(username)
      if user
        if user.password != password
          user = nil
        end
      end
      user
 	end	
	
end
