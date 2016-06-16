class EntryController < ApplicationController

	def index		
		if params[:street_name].present?
			@entries = Entry.where(street_name: params[:street_name])
		else
			@entries = Entry.take(10)
		end
  end
 
	def show
  	@entry = Entry.find(params[:id])
	end

end
