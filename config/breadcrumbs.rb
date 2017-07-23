crumb :root do
  link 'TOP', root_path
end

# Top > お問い合わせ
crumb :contact do
  link 'お問い合わせ', contact_path
end

# TOP > xxについて
crumb :about do
  link 'xxについて', about_path
end

# Top > タグ一覧
crumb :tags do
  link 'タグ一覧', tags_path
end

# Top > タグ一覧 > {タグ名}
crumb :tag do |tag|
  link tag, tag_path(tag)
  parent :tags
end

# Top > カテゴリ一覧
crumb :categories do
  link 'カテゴリ一覧', categories_path
end

# Top > カテゴリ一覧 > {カテゴリ名}
crumb :category do |category|
  link category, category_path(category)
  parent :categories
end

# Top > {ユーザ名}
crumb :user do |user|
  link user.display_name, user_path(user)
end

# Top > マイページ
crumb :my_account do
  link 'マイページ', account_path
end

# Top > マイページ > プロフィール編集
crumb :edit_profile do
  link 'プロフィール編集', edit_user_registration_path
  parent :my_account
end

# Top > マイアカウント > アップロード
crumb :upload do
  link 'アップロード', upload_path
  parent :my_account
end

# Top > {スライドタイトル}
crumb :slide do |slide|
  link truncate(slide.title, length: 10), slide_path(slide)
end

# Top > マイアカウント > {スライド名} > 編集
crumb :edit_slide do |slide|
  link '編集', edit_admin_slide_path(slide)
  parent :slide, slide
end
