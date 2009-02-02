require 'curb'

module EmbeditRuby
  class Image
    
    attr_accessor :xml
    
    def initialize(image, api_key, frog_key, size={})
      c = Curl::Easy.new("http://embedit.me/image/new.xml/")
      c.multipart_form_post = true
      c.http_post(Curl::PostField.file('image', image),
        Curl::PostField.content('api_key', api_key.to_s),
        Curl::PostField.content('frog_key', frog_key.to_s),
        Curl::PostField.content('width', size[:width].to_s),
        Curl::PostField.content('height', size[:height].to_s))
      @xml = EmbeditRuby::Parser.new(c.body_str)
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