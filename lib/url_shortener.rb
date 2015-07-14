module UrlShortener

  #TODO: refactor to move domain config into ENV vars
  DOMAIN = 'localhost:3000'
  HTTP = "http://"
  UNIQUE_KEY_LENGTH = 5
  KEY_CHARS = ('a'..'z').to_a + (0..9).to_a

  def generate_short_url(long_url)
    charset = KEY_CHARS
    key = (0...UNIQUE_KEY_LENGTH).map{ charset[rand(charset.size)] }.join
    HTTP + DOMAIN + "/#{key}"
  end

  module_function :generate_short_url

end
