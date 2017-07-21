module SlidesHelper
  include ActsAsTaggableOn::TagsHelper

  def outline_format(outline)
    return content_tag(:div, '処理中です。') if outline.nil? || outline.body.nil?
    sections = outline.body.split(/\|{6}/)

    content_tag_push(:div, class: 'slide-outline-container') do |div|
      sections.each do |section|
        section =~ /\[-(\d+)-\]/
        div << content_tag_push(:p) do |p_tag|
          p_tag << content_tag(:a, $1, class: 'slide-page-number', data: { num: $1.to_i })
          p_tag << content_tag(:span, $')
        end
      end
    end
  end

  def note_format(outline)
    return content_tag(:div, 'ノートは登録されていません') if outline.nil? || outline.note.nil?

    content_tag(:div, outline.note, class: 'slide-note-container')
  end

  private

  def content_tag_push(type, *option)
    tags = []
    yield tags
    content_tag(type, tags.reduce(:+), *option)
  end
end
