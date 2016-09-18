class RealtorEntriesController < ApplicationController

  # skip validation
  skip_before_filter :verify_authenticity_token

  def create
    if params[:query_address].present?
      @num_pages_scraped = RealtorExtractorService.new.fetch_by_address(params[:query_address], params[:margin].to_f)
    elsif params[:lat].present? && params[:lon].present?
      @num_pages_scraped = RealtorExtractorService.new.fetch_by_geo_location(params[:lat].to_f, params[:lon].to_f, params[:margin].to_f)
    end
    render action: "index"
  end

  def index
    @q = RealtorEntry.ransack(params[:q])
    @realtor_entries = @q.result.paginate(page: params[:page], per_page: params[:per_page])
  end

  def show
    @realtor_entry = RealtorEntry.find(params[:id])
  end

end
