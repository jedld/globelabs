require "net/https"
require "uri"
require "json"

module Globelabs
  class Sms
    ENDPOINT_SMS = "https://devapi.globelabs.com.ph/smsmessaging/v1/"

    attr_accessor :access_token, :sender_shortcode

    def initialize(access_token, sender_shortcode = nil)
      @access_token = access_token
      @sender_shortcode = sender_shortcode
    end

    def send_sms(address, message, client_correlator = nil)
      uri = URI.parse(ENDPOINT_SMS + "outbound/#{@sender_shortcode}/requests?access_token=#{@access_token}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      post = Net::HTTP::Post.new(uri.request_uri)
      form_data = { address: address, message: message, client_correlator: client_correlator }.reject { |_k, v| v.nil? }
      post.set_form_data(form_data)
      response = http.request(post)
      JSON.parse(response.body)
    end
  end
end
