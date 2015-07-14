require 'rails_helper'
require 'uri'

RSpec.describe UrlShortener do
  it 'shortens a long url into a 5 char valid url' do
    long_url = "http://a.long.url/that/should/be/shortened/to/5/chars"
    short_url = UrlShortener::generate_short_url(long_url)
    expect(short_url).to match(URI::regexp)
  end
end
