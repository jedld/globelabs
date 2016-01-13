require 'spec_helper'

describe Globelabs::Client do

  before do
    @globe_client = Globelabs::Client.new('some_app_id','some_app_secret')
  end
  it 'has a version number' do
    expect(Globelabs::VERSION).not_to be nil
  end

  it 'Gets access token' do
    VCR.use_cassette("access_token") do
      @globe_client.access_token('jpCqkLxrupM7kjSMaL5EUaLqjrSrxR96SGB5a6t5AMMLUoqkrACLkEn6UgEj84sRazadC89RELuoboGqSRnGnRCx4beEIKBKKMsrXzp9sBoXeEfbjEoau9aRyeHzacXgpkacR65HnqEXnue7XLXf9bzeqsjoKAesAob4BI7jGzrCMaoedSMXR6zuxBzMBCbzjX6seqEEoUG4k69CApMg9UAR5Bbt79R8GSRgq4RSGzLg9Uxo7aKSd8LgjuBLRe4C')
    end
  end
end
