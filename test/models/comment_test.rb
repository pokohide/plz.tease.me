# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  slide_id   :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_slide_id  (slide_id)
#  index_comments_on_user_id   (user_id)
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test 'the truth' do
  #   assert true
  # end
end
