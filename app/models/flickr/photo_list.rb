class Flickr::PhotoList
  include Enumerable

  class << self
    def from(photo_hash)
      paginated_photo_collection = photo_hash["photos"]
      page       = paginated_photo_collection["page"]
      pages      = paginated_photo_collection["pages"]
      photo_page = paginated_photo_collection["photo"].map do |photo|
        id        = photo["id"]
        farm_id   = photo["farm"]
        server_id = photo["server"]
        secret    = photo["secret"]
        title     = photo["title"]

        Flickr::Photo.new(id, farm_id, server_id, secret, title)
      end

      self.new(page, pages, photo_page)
    end
  end

  attr_accessor  :page, :pages, :photos

  def initialize(page, pages, photos)
    @page   = page
    @pages  = pages
    @photos = photos
  end

  def each(&block)
    photos.each do |photo|
      block.call(photo)
    end
  end

  def empty?
    photos.empty?
  end

  def current_page
    page
  end

  def total_pages
    pages
  end

  def limit_value
    Flickr::FlickrAPI.results_per_page
  end
end