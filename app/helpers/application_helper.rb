module ApplicationHelper
  def slide_image_tag(slide)
    if slide.image_file?
      image_tag slide.image_file_url(:medium)
    else
      image_tag 'noimage.png', alt: '変換中'
    end
  end

  def thumbail_tag(user, options = {})
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
            concat content_tag(:i, '', class: 'close icon')
          end
        )
      end
    end
  end

  def field(object, attribute)
    "field#{object.errors[attribute].empty? ? '' : ' error'}"
  end

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def assign_meta_tags(options = {})
    defaults = t('meta_tags.defaults')
    options.reverse_merge!(defaults)
    image = options[:image].presence || image_url('noimage.png')

    site = options[:site]
    title = options[:title]
    description = options[:description]

    configs = {
      separator: '|',
      reverse: true,
      site: site,
      title: title,
      description: description,
      keywords: options[:keywords],
      canonical: request.original_url,
      og: {
        type: 'article',
        title: title.presence || site,
        description: description,
        url: request.original_url,
        image: image,
        site_name: site
      },
      fb: {
        app_id: '*****'
      },
      twitter: {
        site: '@twitter_account',
        card: 'summary'
      }
    }
    set_meta_tags(configs)
  end

  private

  def flash_class(level)
    case level
    when 'success' then 'ui green message flash-message'
    when 'error', 'danger', 'alert' then 'ui red message flash-message'
    when 'notice' then 'ui blue message flash-message'
    end
  end
end
