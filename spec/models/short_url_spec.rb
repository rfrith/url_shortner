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

  it "is searchable" do
    url1 = "https://this.is.the.long/url/to/shorten1"
    url2 = "https://this.is.the.long/url/to/shorten2"
    url3 = "https://this.is.the.long/url/to/shorten3"

    short1 = ShortUrl.create!(long: url1)
    short2 = ShortUrl.create!(long: url2)
    short3 = ShortUrl.create!(long: url3)

    results = ShortUrl.search("https://this.is.the.long/url/to/shorten")
    expect(results.size).to equal(3)

    results = ShortUrl.search(url1)
    expect(results.size).to equal(1)
    expect(results[0].long).to eql(url1)

    results = ShortUrl.search(short1.short)
    expect(results.size).to equal(1)
    expect(results[0].long).to eql(short1.long)
  end

  it "is agnostic to '0', 'O', and 'o' when searching" do
    url1 = "https://this.is.the.long/url/to/shorten"
    url2 = "https://this.is.the.long/url/tO/shOrten"
    url3 = "https://this.is.the.long/url/t0/sh0rten"

    short1 = ShortUrl.create!(long: url1)
    short2 = ShortUrl.create!(long: url2)
    short3 = ShortUrl.create!(long: url3)

    search = "https://this.is.the.long/url/to/shorten"

    results = ShortUrl.search(search)
    expect(results.size).to equal(3)
    expect(results[0].long).to eql(search)
    expect(results[1].long).not_to eql(search)
    expect(results[2].long).not_to eql(search)

  end


end
