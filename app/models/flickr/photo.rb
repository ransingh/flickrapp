class Flickr::Photo
  attr_accessor :id,
                :farm_id,
                :server_id,
                :secret,
                :title

  class << self
    def from(hash)
      photo_hash= hash["photo"]
      id        = photo_hash["id"]
      farm_id   = photo_hash["farm"]
      server_id = photo_hash["server"]
      secret    = photo_hash["secret"]
      title     = photo_hash["title"]["_content"] || photo_hash["title"]

      self.new(id, farm_id, server_id, secret, title)
    end
  end

  def initialize(id, farm_id, server_id, secret, title)
    @id        = id
    @farm_id   = farm_id
    @server_id = server_id
    @secret    = secret
    @title     = title
  end

  def thumbnail_url
    "https://farm#{farm_id}.staticflickr.com/#{server_id}/#{id}_#{secret}_t.jpg"
  end

  def large_photo_url
    "https://farm#{farm_id}.staticflickr.com/#{server_id}/#{id}_#{secret}_z.jpg"
  end
end
