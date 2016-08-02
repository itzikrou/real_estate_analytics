class SchoolHoodService
  def self.fetch_urls
    urls = []
    Gmail.new(ENV['GMAIL_USERNAME'], ENV['GMAIL_PASSWORD']) do |gmail|
      emails = gmail.inbox.emails(:unread).each{|email|
      puts "Read Email Executing"
      email_body = email.body.to_s     
      if email_body.include?(START_URL_MARKER)       
        url_key_start = email_body.index(START_URL_MARKER) + START_URL_MARKER.size
        url_key_end = email_body.index(END_URL_MARKER) - 1
        urls << build_link(email_body[url_key_start..url_key_end])   
        email.read!
      end
    }
    end
    urls
  end

  def self.build_link(key)
    key.gsub!("\n", "")
    key.gsub!("3D", "")
    key.gsub!("&", "")
    base_link = "http://v3.torontomls.net/Live/Pages/Public/Link.aspx?Key=#{key}&App=TREB"
  end

private

  START_URL_MARKER  = '?Key='
  END_URL_MARKER    = '&App='

end