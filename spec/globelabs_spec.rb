require 'spec_helper'

describe Globelabs::Client do

  before do
    @globe_client = Globelabs::Client.new('some_app_id', 'some_app_secret')
  end
  it 'has a version number' do
    expect(Globelabs::VERSION).not_to be nil
  end

  it 'Gets access token' do
    VCR.use_cassette("access_token") do
      @globe_client.access_token('jpCqkLxrupM7kjSMaL5EUaLqjrSrxR96SGB5a6t5AMMLUoqkrACLkEn6UgEj84sRazadC89RELuoboGqSRnGnRCx4beEIKBKKMsrXzp9sBoXeEfbjEoau9aRyeHzacXgpkacR65HnqEXnue7XLXf9bzeqsjoKAesAob4BI7jGzrCMaoedSMXR6zuxBzMBCbzjX6seqEEoUG4k69CApMg9UAR5Bbt79R8GSRgq4RSGzLg9Uxo7aKSd8LgjuBLRe4C')
    end
  end

  describe "SMS" do
    before do
      @globe_client.access_token = 'tX1pz34Jbyg-oIb417dMYrYMuFkJ-6GskFo8iDEX1gk'
      @sms = @globe_client.sms('21580000')
    end

    it 'Sends an sms' do
      VCR.use_cassette("send_sms") do
        response = @sms.send_sms('9277780000', 'Hello World!')
        expect(response['outboundSMSMessageRequest']['address']).to eq('9277780000')
      end
    end

    it 'Sends an sms using the direct API' do
      VCR.use_cassette('send_sms_direct') do
        response = @sms.send_sms_direct('some_pass_phrase', '9277780000', "Hello World!")
        expect(response['outboundSMSMessageRequest']['address']).to eq('9277780000')
      end
    end
  end
end
