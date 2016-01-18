require "net/https"
require "uri"
require "json"

module Globelabs
  class Client
    attr_accessor :subscriber_number, :access_token

    ENDPOINT_OAUTH = "https://developer.globelabs.com.ph/oauth/"

    def initialize(app_id, app_secret, access_token = nil)
      @app_id, @app_secret, @access_token = app_id, app_secret, access_token
    end

    def access_token(code)
      uri = URI.parse(ENDPOINT_OAUTH + "access_token?app_id=#{@app_id}&app_secret=#{@app_secret}&code=#{code}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      post = Net::HTTP::Post.new(uri.request_uri)
      post.set_form_data(app_id: @app_id, app_secret: @app_secret, code: code)
      response = http.request(post)
      response = JSON.parse(response.body)
      @access_token = response["access_token"]
      @subscriber_number = response["subscriber_number"]
      @access_token
    end

    def sms(sender_shortcode = nil)
      raise "access_token is required" unless @access_token
      Globelabs::Sms.new(@access_token, sender_shortcode)
    end

  end
end
