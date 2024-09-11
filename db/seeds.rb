min_days_ago = 1
max_days_ago = 365
random_days_ago = rand(min_days_ago..max_days_ago)
random_date = Time.now - random_days_ago.days

Admin.create(email: '1@1', password: '111111')
Tag.create(name: 'デブ猫')
Category.create(name:'猫')
Category.create(name:'犬')
Category.create(name:'鳥')
Category.create(name:'馬')
Category.create(name:'兎')
Category.create(name:'蛇')
Category.create(name:'熊')
Category.create(name:'魚')

User.create(
  name:"サンプル太郎",
  email:'12345@com',
  password:'123456',
  birthday: random_date,
  gender:0,
  hope:0,
  post_code:'1234567',
  address:'日本',
  phone:'012007218585',
  introduction:'サンプルユーザーです。'
  )

Pet.find_or_create_by!(name: 'サンプルペット') do |pet|
  pet.user_id = 1
  pet.category_id = 1
  pet.age = 1000
  pet.gender = 1
  pet.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/no_image.jpg"), filename:"no_image.jpg")
end

Album.find_or_create_by!(title: 'サンプル') do |album|
  album.pet_id = 1
  album.user_id = 1
  album.body = 'サンプルです。'
  album.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/no_image.jpg"), filename:"no_image.jpg")
end