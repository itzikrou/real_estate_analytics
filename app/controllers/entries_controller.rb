class EntriesController < ApplicationController

	# def index		
	# 	@entries = Entry.all
	#   if params[:search]
	#     @entries = Entry.search(params[:search]).order("created_at DESC")	    
	#   else
	#     @entries = Entry.all.order('created_at DESC')
	#   end
 #  end

  def index 	
	  @q = Entry.ransack(params[:q])
	  @entries = @q.result(distinct: true)
	end
 
	def show		
  	@entry = Entry.find(params[:id])
	end

	def create
	end

end
