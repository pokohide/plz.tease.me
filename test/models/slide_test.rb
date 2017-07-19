# == Schema Information
#
# Table name: slides
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  title          :string
#  slug           :string
#  is_public      :boolean          default(FALSE), not null
#  pdf_file       :string
#  image_file     :string
#  published_at   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  page_view      :integer          default(0)
#  uploaded       :boolean          default(FALSE)
#  comments_count :integer          default(0)
#  likes_count    :integer          default(0)
#
# Indexes
#
#  index_slides_on_user_id  (user_id)
#

require 'test_helper'

class SlideTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
