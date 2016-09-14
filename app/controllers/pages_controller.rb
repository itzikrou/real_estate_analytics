class PagesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index
    @pages = Page.where.not(url: nil)
  end

  def create
    if params[:url].present?
      @page = Page.find_or_create_by(url: params[:url])
    end
  end
end
