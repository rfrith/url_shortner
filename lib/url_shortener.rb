module UrlShortener
  DOMAIN = Rails.application.secrets.domain
  UNIQUE_KEY_LENGTH = Rails.application.secrets.unique_key_length
  KEY_CHARS = ('a'..'z').to_a + (0..9).to_a
  BLACK_LIST = Rails.application.secrets.black_list.split(',')

  def generate_short_url(long_url)
    key_is_valid = false
    until key_is_valid
      key = (0...UNIQUE_KEY_LENGTH).map{ KEY_CHARS[rand(KEY_CHARS.size)] }.join
      BLACK_LIST.each do |term|
        key_is_valid = !key.downcase.include?(term.downcase)
        break if(!key_is_valid)
      end
    end
    DOMAIN + "/#{key}"
  end

  module_function :generate_short_url

end
