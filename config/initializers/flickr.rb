flicker_keys = YAML.load(File.read("#{Rails.root}/config/flickr.yml"))[Rails.env]

puts "flicker_keys: #{flicker_keys}"

Flickr::FlickrAPI.key              = flicker_keys["key"]
Flickr::FlickrAPI.secret           = flicker_keys["secret"]
Flickr::FlickrAPI.service_url      = flicker_keys["service_url"]
Flickr::FlickrAPI.results_per_page = flicker_keys["results_per_page"]



