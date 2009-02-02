module EmbeditRuby
  class Parser
    attr_reader :title, :format, :url, :html, :fbml, :error_messages
  
    def initialize(xml)
      xml = REXML::Document.new(xml)
      @title = REXML::XPath.first(xml, "//title").text
      @format = REXML::XPath.first(xml, "//format").text
      @html = REXML::XPath.first(xml, "//html").text   # Service will provide a way to change size, this may be providing user with regex pattern to the sizes, so the wrapper can change it
      @url = REXML::XPath.first(xml, "//url").text
      @fbml = REXML::XPath.first(xml, "//fbml").text
      @valid = REXML::XPath.first(xml, "//valid").text
      @error_messages = REXML::XPath.first(xml, "//error_messages").text
    end
  
    def valid?
      @valid
    end
  end
end