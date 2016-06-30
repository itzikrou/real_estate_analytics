class PagesController < ApplicationController
  
  skip_before_filter :verify_authenticity_token

  def index
    @pages = Page.all
  end

  def create
    if params[:url].present?
      @page = Page.create!(url: params[:url])
    end
  end
end
