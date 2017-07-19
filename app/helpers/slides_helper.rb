module SlidesHelper
  include ActsAsTaggableOn::TagsHelper

  def outline_format(outline)
    sections = outline.split(/\|{6}/)

    content_tag_push(:div, class: 'slide-outline-container') do |div|
      sections.each do |section|
        section =~ /\[-(\d+)-\]/
        div << content_tag_push(:p) do |p_tag|
          p_tag << content_tag(:a, "#{$1}")
          p_tag << content_tag(:span, "#{$'}")
        end
      end
    end
  end

  private

  def content_tag_push(type, *option)
    tags = []
    yield tags
    content_tag(type, tags.reduce(:+), *option)
  end
end
