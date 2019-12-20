module ApplicationHelper
  def active_link_to(name = nil, options = nil, html_options = nil, &block)
    active_class = html_options[:active] || "active"
    html_options.delete(:active)
    html_options[:class] = "#{html_options[:class]} #{active_class}" if current_page?(options)
    link_to(name, options, html_options, &block)
  end

  def user_image(user, options = {} )
    if user.image.attached?
      image_tag user.image, options
    else
      image_tag 'default_image.png', options
    end
  end

  def gen_public_string(is_public)
    is_public ? t(:public) : t(:only_me)
  end
end
