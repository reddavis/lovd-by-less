module ApplicationHelper
  require 'digest/sha1'
  require 'net/http'
  require 'uri'
  
  

  def less_form_for name, *args, &block
    options = args.extract_options!
    form_for name, *(args << options.merge(:builder=>LessFormBuilder)), &block
  end
  
  def less_remote_form_for name, *args, &block
    options = args.extract_options!
    remote_form_for name, *(args << options.merge(:builder=>LessFormBuilder)), &block
  end
  
  

  def display_standard_flashes(message = 'There were some problems with your submission:')
    if flash[:notice]
      flash_to_display, level = flash[:notice], 'notice'
    elsif flash[:warning]
      flash_to_display, level = flash[:warning], 'warning'
    elsif flash[:error]
      level = 'error'
      if flash[:error].instance_of?( ActiveRecord::Errors) || flash[:error].is_a?( Hash)
        flash_to_display = message
        flash_to_display << activerecord_error_list(flash[:error])
      else
        flash_to_display = flash[:error]
      end
    else
      return
    end
    content_tag 'div', flash_to_display, :class => "flash#{level}"
  end

  def activerecord_error_list(errors)
    error_list = '<ul class="error_list">'
    error_list << errors.collect do |e, m|
      "<li>#{e.humanize unless e == "base"} #{m}</li>"
    end.to_s << '</ul>'
    error_list
  end
    
  def inline_tb_link(link_text, inlineId, html = {}, tb = {})
    html_opts = {
      :title => '',
      :class => 'thickbox'
    }.merge!(html)
    tb_opts = {
      :height => 320,
      :width => 400,
      :inlineId => inlineId
    }.merge!(tb)
                        
    path = '#TB_inline'.add_param(tb_opts)
    link_to(link_text, path, html_opts)
  end                   
  
  def tb_video_link(embedit_data)
    return "(video not found)" if embedit_data.nil?
    id = Digest::SHA1.hexdigest("--#{embedit_data.title}--")
    inline_tb_link(embedit_data.title, h(id), {}, {:height => 355, :width => 430}) + %(<div id="#{h(id)}" style="display:none;">#{embedit_data.html}</div>)
  end
  
  def me
    @p == @profile
  end
  
  def is_admin? user = nil
    user && user.is_admin?
  end
  
  def if_admin
    yield if is_admin? @u
  end
  
  def body_content(post, main_object)
    out = sanitize textilize(post)
    embedables = post.scan(EmbeditRuby::REGEX).each do |embed|
      embedit = grab_embed(embed, main_object)
      if embedit
        out.gsub!(embed, "<center>#{embedit.html}</center>")
      end
    end
    out
  end
  
  # Main object would be Blog, Comment etc
  def grab_embed(post, main_object)
    b = post.match(EmbeditRuby::EXTRACT_URL)
    url = b[1].nil? ? b[2].strip! : b[1].strip!
    embedit_data = main_object.embeds.find_by_url(url)
  end
  
end
