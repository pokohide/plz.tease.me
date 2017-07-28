class EmbedsController < ApplicationController
  before_action :set_options

  def show
    @slide = Slide.find_by(slug: params[:slug])
    @slide.statistics.increment(:embed_view).save
    render layout: false
  end

  private

  def set_options
    @options = default_options.merge(params)
  end

  def default_options
    {
      'theme' => 'black', # 背景色
      'showinfo' => 1, # タイトルバーを表示するか
      'fs' => 1, # フルスクリーン表示をONにするか
      'modestbranding' => 0, # ブランド画像を消すかどうか
      'start' => 0, # 開始スライド
      'controls' => 1 # ツールバーを表示するかどうか
    }
  end
end
