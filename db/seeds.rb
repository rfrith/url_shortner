# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

url1 = "https://github.com/rfrith/url_shortner"
url2 = "https://www.dropbox.com/s/57mh1wk07e89ggz/RyanFrithResume.pdf?dl=0"
url3 = "https://www.dropbox.com/s/rmb4icf7u5rp52s/RyanFrithCV.pdf?dl=0"

ShortUrl.create!(long: url1)
ShortUrl.create!(long: url2)
ShortUrl.create!(long: url3)