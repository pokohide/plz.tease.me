class Pdf2outlineJob < ApplicationJob
  queue_as :default

  def perform(slide_id)
    slide = Slide.find(slide_id)
    pdf = Poppler::Document.new(open(slide.pdf_file.to_s).read)

    text = ''
    pdf.pages.each_with_index do |page, index|
      text += "[-#{index + 1}-] #{page.get_text}"
      text += "\n||||||" if index != pdf.size - 1
    end

    slide.with_lock do
      outline = slide.slide_outline || slide.build_slide_outline
      outline.body = text
      outline.save!
    end
  end
end
