class Pdf2pngJob < ApplicationJob
  queue_as :default

  def perform(slide)
    pdf_file_path = slide.pdf_file.path
    Dir.mktmpdir do |dir|
      png_basename = File.basename(pdf_file_path = slide.pdf_file.path, '.*')
      # pdf の 1 ページ目のみを png に変換
      `pdftocairo -png -singlefile #{pdf_file_path} #{dir}/#{png_basename}`

      # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-%22Upload%22-from-a-local-file
      # carrier_wave 内で close が呼ばれる
      slide = Slide.lock.find(slide.id)
      slide.image_file = File.open("#{dir}/#{png_basename}.png")
      slide.save!
    end
  end
end
