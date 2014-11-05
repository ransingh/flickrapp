class PhotosController < ApplicationController


  def search
    text_query = params[:query]
    requested_page  = params[:page] || 1
    begin
      @photos = Flickr::FlickrAPI.search(text_query, page: requested_page)
      flash.now[:notice] = "No results." if @photos.empty?
    rescue => e
      Rails.logger.debug("#{e.message}")
      flash.now[:error] = "Oh snap! Something went wrong and try again."
    end
  end

  def show
    @photo = Flickr::FlickrAPI.find_photo(params[:id])
  end
end