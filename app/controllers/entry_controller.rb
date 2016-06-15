class EntryController < ApplicationController
	def index		
    	@entries = Entry.all.take(6000)   	
  	end
 
  	def show
    	@entry = Entry.find(params[:id])
  	end
end
