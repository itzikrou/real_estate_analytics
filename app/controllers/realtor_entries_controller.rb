class RealtorEntriesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create    
    if params[:query_address].present?
      @num_pages_scraped = RealtorExtractorService.new.fetch_by_address(params[:query_address], params[:margin].to_f)
      render action: "index"
    end
  end
end