class EntryController < ApplicationController

	before_action :set_params

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


  	def set_params

  	end
end
