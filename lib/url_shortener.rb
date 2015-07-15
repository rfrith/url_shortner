module UrlShortener
  DOMAIN = "#{Rails::Server.new.options[:Host]}:#{Rails::Server.new.options[:Port]}"
  HTTP = "http://"
  UNIQUE_KEY_LENGTH = 5
  KEY_CHARS = ('a'..'z').to_a + (0..9).to_a
  BLACK_LIST = ["foo","bar"]

  def generate_short_url(long_url)
    key_is_valid = false
    until key_is_valid
      key = (0...UNIQUE_KEY_LENGTH).map{ KEY_CHARS[rand(KEY_CHARS.size)] }.join
      BLACK_LIST.each do |term|
        key_is_valid = !key.downcase.include?(term.downcase)
        break if(!key_is_valid)
      end
    end
    HTTP + DOMAIN + "/#{key}"
  end

  module_function :generate_short_url

end
