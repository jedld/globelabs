require "net/https"
require "uri"
require "json"

module Globelabs
  class Sms
    class RequestError < Exception
      attr_accessor :message
      def initialize(message)
        @message = message
      end
    end

    ENDPOINT_SMS = "https://devapi.globelabs.com.ph/smsmessaging/v1/"

    attr_accessor :access_token, :sender_shortcode, :passphrase

    def initialize(client, access_token = nil, sender_shortcode = nil, passphrase = nil)
      @access_token = access_token
      @sender_shortcode = sender_shortcode
      @client = client
      @passphrase = passphrase
    end

    # Sends an sms without a token (requires special access/permissions from Globe)
    def send_sms_direct(address, message, client_correlator = nil)
      uri = URI.parse("#{ENDPOINT_SMS}outbound/#{@sender_shortcode}/requests?app_id=#{@client.app_id}&app_secret=#{@client.app_secret}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      post = Net::HTTP::Post.new(uri.request_uri)
      form_data = { address: address,
                    message: message,
                    client_correlator: client_correlator,
                    passphrase: @passphrase
                  }.reject { |_k, v| v.nil? }
      post.set_form_data(form_data)
      response = http.request(post)
      JSON.parse(response.body).tap { |r| raise RequestError.new(r["error"]) if r["error"] }
    end

    # Sends an sms
    def send_sms(address, message, client_correlator = nil)
      uri = URI.parse(ENDPOINT_SMS + "outbound/#{@sender_shortcode}/requests?access_token=#{@access_token}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      post = Net::HTTP::Post.new(uri.request_uri)
      form_data = { address: address, message: message, client_correlator: client_correlator }.reject { |_k, v| v.nil? }
      post.set_form_data(form_data)
      response = http.request(post)
      JSON.parse(response.body).tap { |r| raise RequestError.new(r["error"]) if r["error"] }
    end
  end
end
