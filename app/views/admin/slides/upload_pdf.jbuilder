json.slide do
  json.call(@slide, :id, :title, :slug)
  json.pdf_url @slide.pdf_file.to_s
end
