require 'rest_client'

class Flickr::Http
  class << self
    def get(url, query, &block)
      Rails.logger.debug(url)
      Rails.logger.debug(query)

      response = do_get(url, :params => query)
      block.call(response)
    end

    private

    def do_get(url, params)
      resource = RestClient::Resource.new(url, :verify_ssl => false)
      response =resource.get(params)
      Rails.logger.debug(response)
      JSON.parse(response.body)
    rescue JSON::ParserError => jpe
      Rails.logger.debug("#{jpe.message} \n\n #{jpe.backtrace.join("\n")}")
      {
        stat: 'fail',
        message: jpe.message
      }
    rescue => e
      Rails.logger.debug("#{e.message} \n\n #{e.backtrace.join("\n")}")
      {
        stat: 'fail',
        message: "#{e.message} \n\n #{e.backtrace.join("\n")}"
      }
    end
  end
end