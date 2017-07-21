class Pdf2pngJob < ApplicationJob
  queue_as :default

  def perform(slide_id)
    slide = Slide.lock.find(slide_id)
    page = slide.pages.order(:num).first

    slide.image_file = page.image
    slide.save
  end
end
