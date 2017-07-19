# == Schema Information
#
# Table name: statistics
#
#  id             :integer          not null, primary key
#  slide_id       :integer
#  download_count :integer          default(0)
#  embed_views    :integer          default(0)
#  share_count    :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_statistics_on_slide_id  (slide_id)
#

class Statistic < ApplicationRecord
  belongs_to :slide
end
