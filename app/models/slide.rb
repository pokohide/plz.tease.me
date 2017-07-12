# == Schema Information
#
# Table name: slides
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  title         :string
#  slug          :string
#  is_public     :boolean          default(FALSE), not null
#  original_file :string
#  pdf_file      :string
#  image_file    :string
#  published_at  :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_slides_on_user_id  (user_id)
#

class Slide < ApplicationRecord
end
