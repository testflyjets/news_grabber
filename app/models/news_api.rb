require 'open-uri'
require 'json'
require 'date'

class NewsApi
   API_SERVER = 'api.nytimes.com'
   API_VERSION = 'v3'
   API_NAME = 'news'
   API_BASE = "/svc/#{API_NAME}/#{API_VERSION}/content"

   @@api_key = TimesWire::Base.api_key

   def self.invoke(path, params={})
      full_params = params.merge 'api-key' => @@api_key

      uri = build_request_url(path, full_params)

      reply = uri.read
      parsed_reply = JSON.parse reply

      if parsed_reply.nil?
        raise "Empty reply returned from API"
      end

      parsed_reply
   end

    def self.build_request_url(path, params)
      URI::HTTP.build :host => API_SERVER, :path => "#{API_BASE}/#{path}.json", 
        :query => params.map{ |k,v| "#{k}=#{v}" }.join('&')
    end
end