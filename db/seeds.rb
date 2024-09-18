min_days_ago = 1
max_days_ago = 365
random_days_ago = rand(min_days_ago..max_days_ago)
random_date = Time.now - random_days_ago.days

tmp_admin = Admin.find_or_create_by!(email: ENV['ADMIN_MAIL']) do |admin|
 admin.password = ENV["ADMIN_PASS"]
end

tmp_tag = Tag.find_or_create_by!(name: 'デブ猫')

tmp_category = Category.find_or_create_by!(name: '猫') do |category|
  category.introduction = "みんな大好き猫ちゃん！様々な種類がおり性格も様々。"
  category.difficulty = 1
  category.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/cat_image.jpg"), filename:"cat_image.jpg")
end  


tmp_user = User.find_or_create_by!(email: "12345@com") do |user|
  user.name = "サンプル太郎"
  user.email = '12345@com'
  user.password = '123456'
  user.birthday =  random_date
  user.gender = 0
  user.hope = 0
  user.post_code = '1234567'
  user.address = '日本'
  user.phone = '01200721858'
  user.introduction = 'サンプルユーザーです。'
end

tmp_pet = Pet.find_or_create_by!(name: 'サンプルペット') do |pet|
  pet.user_id = tmp_user.id
  pet.category_id = tmp_category.id
  pet.age = 1000
  pet.gender = 1
  pet.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/no_image.jpg"), filename:"no_image.jpg")
end

Album.find_or_create_by!(title: 'サンプル') do |album|
  album.pet_id = tmp_pet.id
  album.user_id = tmp_user.id
  album.body = 'サンプルです。'
  album.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/no_image.jpg"), filename:"no_image.jpg")
end

