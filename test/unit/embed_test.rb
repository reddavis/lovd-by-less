require 'test_helper'

class EmbedTest < ActiveSupport::TestCase
  
  context 'An embed instance' do
    should_belong_to :embed_owner
  end
  
  # Valid Urls
  should 'Increase count if comment contains valid embed in COMMENT' do
    assert_difference "Embed.count" do
      create_comment
    end
  end
  
  should 'Increase count if blog contains valid embed in BLOG' do
    assert_difference "Embed.count" do
      create_blog(:body => valid_embed_body)
    end
  end
  
  # Invalid Urls
  should 'Not change the embed count for invalid url in BLOG' do
    assert_no_difference "Embed.count" do
      create_blog(:body => invalid_embed_body)
    end
  end
  
  should 'Not change the embed count for invalid url in COMMENT' do
    assert_no_difference "Embed.count" do
      create_comment(:comment => invalid_embed_body)
    end
  end
  
  private
  
  def create_comment(options={})
    p = profiles(:user3)
    comment = create_blog.comments.create({:comment => valid_embed_body, :profile_id => p.id}.merge(options))
  end
  
  def valid_embed_body
    <<-EOF
      This is just a comment, nothing special, oh, heres an embed [embedit: http://vimeo.com/2435628] it sure
      sure is valid, promise.
    EOF
  end
  
  def invalid_embed_body
    <<-EOF
      This is just a comment, nothing special, oh, heres an embed [embedit: http://vimeo.com/thisistotallyfake628] it sure
      sure is not valid, promise.
    EOF
  end
    
  def create_blog(options={})
    p = profiles(:user2)
    blog = p.blogs.create({:title => 'title', :body => 'some body mmmm'}.merge(options))
    blog
  end

end
