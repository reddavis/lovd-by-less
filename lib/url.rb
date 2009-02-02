module EmbeditRuby
  class Url
  
    attr_reader :xml
  
    def initialize(url, size={}, api_key=nil, frog_key=nil)
      url = CGI.escape(url)
      @xml = EmbeditRuby::Parser.new(open("http://embedit.me/url/new.xml/?url=#{url}&height=#{size[:height]}&width=#{size[:width]}&api_key=#{api_key}&frog_key=#{frog_key}"))
    end
    
    def title
      xml.title
    end
    
    def format
      xml.format
    end
    
    def url
      xml.url
    end
    
    def html
      xml.html
    end
    
    def fbml
      xml.fbml
    end
    
    def valid?
      xml.valid?
    end
    
    def error_messages
      xml.error_messages
    end
    
  end
end