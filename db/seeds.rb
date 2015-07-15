# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

url1 = "http://this.is.the.long/url/to/shorten"
url2 = "http://this.is.the.long/url/tO/shOrten"
url3 = "http://this.is.the.long/url/t0/sh0rten"

ShortUrl.create!(long: url1)
ShortUrl.create!(long: url2)
ShortUrl.create!(long: url3)