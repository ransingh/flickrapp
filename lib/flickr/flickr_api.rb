require 'flickr/http'
require 'flickr/photo'

class Flickr::FlickrAPI
  class << self
    attr_accessor :key, :secret, :service_url, :results_per_page

    def search(text_query, options)
      params = {
        :text     => text_query,
        :per_page => results_per_page,
        :page     => options[:page],
        :method   => "flickr.photos.search"
      }.merge!(default_params)

      Flickr::Http.get(service_url, params) do |photos_hash|
        raise Flickr::FlickrHttpResponseError.new(photos_hash["message"]) if photos_hash[:stat] == 'fail'
        Flickr::PhotoList.from(photos_hash)
      end
    end

    def find_photo(photo_id)
      params = {
        :photo_id => photo_id,
        :method => "flickr.photos.getInfo"
      }.merge!(default_params)

      Flickr::Http.get(service_url, params) do |photo_hash|
        raise Flickr::FlickrHttpResponseError.new(photo_hash["message"]) if photo_hash[:stat] == 'fail'
        Flickr::Photo.from(photo_hash)
      end
    end

    def default_params
      {
        :api_key       => key,
        :format        => 'json',
        :nojsoncallback=> 1
      }.freeze
    end
  end
end

class Flickr::FlickrHttpResponseError < StandardError;end
