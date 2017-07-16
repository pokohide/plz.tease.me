class Pdf2outlineJob < ActiveJob::Base
  queue_as :default

  def perform(slide)
    pdf_file_path = slide.pdf_file.path

    # pdf -> txt に xpdf を使う
    text = `pdftotext -nopgbrk #{pdf_file_path} -`
    slide.with_lock do
      outline = slide.slide_outline || slide.build_slide_outline
      outline.body = text
      outline.save!
    end

    # pdf_file_path = slide.pdf_file.path
    # pdf = Poppler::Document.


    #     pdf_file_path = file.path
    # # pdf -> txt に xpdf を使う
    # # text = `pdftotext -nopgbrk #{pdf_file_path} -`
    # # SlideOutline.new(body: text)
    # pdf = Poppler::Document.new(pdf_file_path)
    # outline = ''
    # pdf.pages.each_with_index do |page, index|
    #   outline += "#{index + 1}. #{page.get_text}"
    #   outline += "\n" if index != pdf.size - 1
    # end
    # SlideOutline.new(body: outline)
  end
end
