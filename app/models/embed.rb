class Embed < ActiveRecord::Base
  
  validates_presence_of :html, :title, :url
  
  belongs_to :embed_owner, :polymorphic => true
  
  before_validation :add_information 
  
  private
  
  def add_information
    embed = EmbeditRuby::Url.new(url)
    if embed.valid? == 'true'
      self.title = embed.title
      self.html = embed.html
    end
  end
  
end
