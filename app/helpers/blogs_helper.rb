module BlogsHelper
  
  def blogs_li blogs
    html = ''
    blogs.each do |b|
      html += "<li>#{link_to b.title, profile_blog_path(@profile, b)} written #{time_ago_in_words b.created_at} ago</li>"
    end
    html
  end
  
  
  def blog_body_content blog  
    out = sanitize textilize(blog.body)
    embedables = blog.body.scan(/\[embedit:.+\]/).each do |embed|
      url = embed.match(/\[embedit:(.+)\]/)[1].strip!
      embedit = EmbeditRuby::Url.new(url, :height => 250)
      if embedit.valid? == 'true'
        out.gsub!(embed, "<center>#{embedit.html}</center>")
      end
    end
    out
  end
end
