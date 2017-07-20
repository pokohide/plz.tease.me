module ApplicationHelper

  def slide_image_tag slide
    if slide.image_file?
      image_tag slide.image_file_url
    else
      image_tag 'noimage.png', alt: '変換中'
      # link_to(image_tag('noimage', alt: '変換中'), slide_path(slide))
    end
  end

  def thumbail_tag user, options = {}
    class_name = options[:class].blank? ? 'thumbnail' : options[:class].to_s + ' thumbnail'
    if user.try(:thumbnail).present?
      image_tag user.thumbnail, class: class_name
    else
      image_tag 'user.png', class: class_name
    end
  end

  def flash_messages
    content_tag(:div, class: 'flash-messages') do
      flash.each do |type, msg|
        concat(
          content_tag(:div, class: flash_class(type)) do
            concat content_tag(:p, msg)
            concat content_tag(:i,'', class: 'close icon')
          end
        )
      end
    end
  end

  def field(object, attribute)
    "field#{object.errors[attribute].empty? ? '' : ' error'}"
  end

  private

  def flash_class level
    case level
    when 'success' then 'ui green message flash-message'
    when 'error', 'danger', 'alert' then 'ui red message flash-message'
    when 'notice' then 'ui blue message flash-message'
    end
  end
end
