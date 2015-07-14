require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  subject { ShortUrl.new(params) }

  it "has a valid factory" do
    short_url = build(:short_url)
    expect(short_url).to be_valid
    expect(short_url.errors[:long]).to be_empty
    expect(short_url.errors[:short]).to be_empty
  end

  it "is valid with a long and short" do
    short_url = ShortUrl.new(long: 'https://www.dropbox.com/s/rmb4icf7u5rp52s/RyanFrithCV.pdf', short: 'http://localhost:3000/shortenedurl')
    expect(short_url).to be_valid
    expect(short_url.errors[:long]).to be_empty
    expect(short_url.errors[:short]).to be_empty
  end

  it "is invalid without a long" do
    short_url = ShortUrl.new(long: nil)
    expect(short_url).not_to be_valid
    expect(short_url.errors[:long]).not_to be_empty
    expect(short_url.errors[:short]).not_to be_empty
  end

  it "is valid without a short as long as a long is supplied" do
    short_url = ShortUrl.new(long: "https://this.is.the.long/url/to/shorten", short: nil)
    expect(short_url).to be_valid
    expect(short_url.errors[:long]).to be_empty
    expect(short_url.errors[:short]).to be_empty
  end

  it "is invalid if it is a duplicate" do
    short_url1 = build(:short_url)
    short_url1.save
    expect(short_url1).to be_valid
    expect(short_url1.errors[:long]).to be_empty
    expect(short_url1.errors[:short]).to be_empty

    short_url2 = build(:short_url)
    short_url2.save
    expect(short_url2).not_to be_valid
    expect(short_url2.errors[:long]).not_to be_empty
    expect(short_url2.errors[:short]).not_to be_empty
  end

end
