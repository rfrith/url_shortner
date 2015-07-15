class ShortUrl < ActiveRecord::Base

  validates_presence_of :short, :if => :long?, :message => "An error occurred creating the shortened URL."
  validates_presence_of :long, :message => "You must supply a value for the original URL."
  validates_uniqueness_of :short, :long, :message => "This URL has already been shortened. Please enter a unique URL."
  format_err = "Please enter a properly formatted URL"
  validates_format_of :short, :with => URI::regexp(%w(http https)), :if => :long?, :message => format_err
  validates_format_of :long, :with => URI::regexp(%w(http https)), :message => format_err

  before_validation do
    shorten if !self.long.blank? and self.short.blank?
  end


  def self.search(query)
    modified_query = query.gsub(/[0Oo]/, '%')  #use wild card to fulfill requirement (see Readme.rdoc)
    where("long like ? or short like ?", "%#{modified_query}%", "%#{modified_query}%")
  end


  private

  def shorten
    self.short = generate_unique_short_url(self.long)
  end

  def generate_unique_short_url(long)
    short = UrlShortener::generate_short_url(long)

    if(ShortUrl.where(short: short ).count > 0) #try again if already in database
      generate_unique_short_url(long)
    else
      ShortUrl.all.each do |url|
        if one_different_char?(short, url.short) #try again if the generated value is similar to existing value in database (see Readme.rdoc)
          generate_unique_short_url(long)
        end
      end
    end
    return short
  end

  def one_different_char?(string1, string2)
    string2_dup = string2.dup #don't modify original string
    string1.chars{|char| string2_dup.sub!(char, '')}
    string2_dup.size == 1
  end

end
