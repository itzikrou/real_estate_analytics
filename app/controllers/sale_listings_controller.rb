class SaleListingsController < ApplicationController
  
  def index   
    @q = SaleListing.ransack(params[:q])
    @sale_listings = @q.result.paginate(page: params[:page], per_page: params[:per_page])
  end

  def show
    @sale_listings = SaleListing.find(params[:id])
  end
end
