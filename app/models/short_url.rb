class ShortUrl < ActiveRecord::Base

  validates_presence_of  :short, :long
  validates_uniqueness_of :short, :long
  validates_format_of :long, :short, :with => URI::regexp(%w(http https))

  before_validation do
    shorten if !self.long.blank? and self.short.blank?
  end


  private

  def shorten
    self.short = generate_unique_short_url(self.long)
  end

  def generate_unique_short_url(long)
    short = UrlShortener::generate_short_url(long)

    #replace zero with 'O' and upcase 'o' to '0' to  fulfill requirement (see Readme.rdoc)
    short.gsub!(/[0o]/, 'O')

    if(ShortUrl.where(short: short ).count > 0) #try again if already in database
      generate_unique_short_url(long)
    else
      ShortUrl.all.each do |url|
        if one_different_char?(short, url) #try again if the generated value is similar to existing value in database (see Readme.rdoc)
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
