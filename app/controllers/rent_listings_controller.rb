class RentListingsController < ApplicationController

  def index
    @q = RentListing.ransack(params[:q])
    @rent_listings = @q.result.paginate(page: params[:page], per_page: params[:per_page])
  end

  def show
    @rent_listings = SaleListing.find(params[:id])
  end
end
