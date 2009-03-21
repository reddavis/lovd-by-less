class Embed < ActiveRecord::Base
  
  validates_presence_of :html, :title, :url
  
  belongs_to :embed_owner, :polymorphic => true
  
  before_validation :add_information 
  
  private
  
  def add_information
    if embed_owner_type == 'Comment' 
      embed = EmbeditRuby::Url.new(url, {:height => 355, :width => 430})
    elsif embed_owner_type == 'Blog'
      if url.match(/twitter/)
        embed = EmbeditRuby::Url.new(url, {:height => 100})
      else
        embed = EmbeditRuby::Url.new(url, {:height => 280})
      end
    end
    if embed.valid? == 'true'
      self.title = embed.title
      self.html = embed.html
    end
  end
  
end

