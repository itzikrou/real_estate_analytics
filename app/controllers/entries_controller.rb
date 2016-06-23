class EntriesController < ApplicationController

  def index  	
	  @q = Entry.ransack(params[:q])
	  @entries = @q.result(distinct: true)
	  @entries.order(updated_at: :desc, street_name: :desc)
	  @res = @entries.last(100)	  
	end
 
	def show		
  	@entry = Entry.find(params[:id])
	end

	def create
	end

end
