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
  end
end
