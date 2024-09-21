min_days_ago = 1
max_days_ago = 365
random_days_ago = rand(min_days_ago..max_days_ago)
random_date = Time.now - random_days_ago.days

tmp_admin = Admin.find_or_create_by!(email: ENV['ADMIN_MAIL']) do |admin|
 admin.password = ENV["ADMIN_PASS"]
end

tmp_category = Category.find_or_create_by!(name: '猫') do |category|
  category.introduction = "猫の魅力は、その独立した性格と愛らしい姿にあります。柔らかい毛、しなやかな動き、そして大きな瞳は、多くの人を惹きつけます。猫は非常に個性的で、飼い主との関係が深まるにつれて、そのユニークな性格がより一層愛おしく感じられます。
                            飼いやすさについては、猫は比較的手間が少ないペットとして人気があります。犬と比べて独立心が強く、一人でいることも苦にしないため、忙しい飼い主にとっても適しています。ただし、遊ぶことが好きな猫も多いため、毎日の遊び時間や刺激を提供することが大切です。
                            食事管理も比較的簡単ですが、猫は肉食性であるため、高品質なキャットフードや新鮮な肉が必要です。定期的な食事管理と水分補給を心がけることで、健康を維持できます。
                            猫は非常に好奇心旺盛で、環境を探検することが好きです。キャットタワーやおもちゃを用意することで、運動不足を防ぎ、ストレスを軽減することができます。また、猫は人とのスキンシップを楽しむこともあり、撫でられることや膝の上でくつろぐことを好む猫も多いです。
                            さらに、猫は独特のコミュニケーションを持っており、鳴き声や体の動きで気持ちを表現します。これにより、飼い主との絆が深まります。
                            総じて、猫はその魅力的な外見や性格、比較的飼いやすさから、多くの人に愛されています。愛情を持って接することで、特別な関係を築くことができ、心温まる伴侶となることでしょう。"
  category.difficulty = 1
  category.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/cat_image.jpg"), filename:"cat_image.jpg")
end  

Category.find_or_create_by!(name: '犬') do |category|
  category.introduction = "犬の魅力は、その忠誠心と愛情深さ、そして多様な性格にあります。犬は「人間の最良の友」と呼ばれることが多く、家族の一員として深い絆を築くことができる存在です。彼らの愛らしい仕草や元気な動きは、見る者を楽しませ、癒してくれます。
                            飼いやすさについては、犬の種類によって異なりますが、一般的には十分な運動や社会的な刺激が必要です。大型犬は広いスペースを必要とし、小型犬は比較的少ないスペースでも飼いやすいですが、いずれにしても散歩や遊びの時間は欠かせません。犬は基本的に群れで生活する動物であり、人間とのコミュニケーションを楽しむため、愛情を持った関わりが重要です。
                            食事管理も大切で、犬にはバランスの取れたドッグフードや新鮮な食材を与えることが必要です。犬種や年齢によって必要な栄養が異なるため、適切な食事を選ぶことが健康維持につながります。
                            犬は非常に知能が高く、しつけやトレーニングが可能です。基本的なコマンドを覚えさせることで、飼い主との関係が深まり、信頼感が生まれます。遊びやトレーニングを通じて、楽しみながら絆を深めることができるのも犬の魅力の一つです。
                            また、犬は感情を豊かに表現する動物で、飼い主の気持ちを敏感に察知します。喜んで尻尾を振ったり、寄り添ったりする姿は、愛情を感じさせてくれます。
                            総じて、犬はその忠誠心、愛情、知能の高さから、多くの人にとって特別な存在です。愛情を注ぎ、しっかりとした世話をすることで、かけがえのないパートナーとしての関係を築くことができるでしょう。"
  category.difficulty = 1
  category.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/inu.jpg"), filename:"inu.jpg")
end 

Category.find_or_create_by!(name: 'ウサギ') do |category|
  category.introduction = "ウサギの魅力は、その愛らしい姿と性格にあります。ふわふわとした毛、長い耳、大きな目は見る者をほっこりさせます。また、ウサギは非常に社交的で、好奇心旺盛な性格を持っています。そのため、飼い主とのコミュニケーションを楽しむことができ、愛情を持って接することで深い絆が築けます。
                           飼いやすさに関しては、ウサギは比較的手軽に飼えるペットとして人気があります。小さなスペースでも飼うことができ、運動もそこまで広い場所を必要としません。しかし、ウサギは運動が大切な動物なので、毎日ケージの外で遊ばせる時間が必要です。
                           食事管理も比較的簡単ですが、草や新鮮な野菜、特にペレットや干し草が主な食事となります。飼い主としては、健康管理や適切な環境を整えることが求められます。"
  category.difficulty = 2
  category.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/bunny.jpg"), filename:"bunny.jpg")
end 

Category.find_or_create_by!(name: '鳥') do |category|
  category.introduction = "鳥類全般の魅力は、その多様性と美しさにあります。色とりどりの羽や独特な鳴き声、さまざまな行動様式は、見る者を惹きつけてやみません。小型のインコやカナリアから、大型のオウムや鷹まで、鳥たちはそれぞれに個性的で、観察する楽しみがあります。
                          飼いやすさについては、鳥の種類によって大きく異なります。小型の鳥（たとえば、セキセイインコや文鳥）は比較的飼いやすく、必要なスペースも小さくて済みます。これに対して、大型のオウムや鳩は、広いケージや十分な遊び場が必要です。また、鳥は非常に社交的な動物で、人とのコミュニケーションを楽しむため、飼い主との関係を大切にすることが重要です。
                          食事も種類によって異なりますが、基本的には種子、果物、野菜が主食です。栄養管理が重要で、バランスの取れた食事を与えることが健康維持につながります。また、特定の鳥はおやつやトリートを好み、これを使ってトレーニングやコミュニケーションを楽しむことができます。
                          鳥の魅力の一つは、その知能の高さです。多くの鳥は簡単なトリックを覚えることができ、飼い主とのインタラクションを楽しむ姿はとても愛らしいです。さらに、彼らは歌を歌ったり、言葉を覚えたりすることもあり、コミュニケーションの楽しさが広がります。
                          総じて、鳥類はその美しさや知能、個性豊かな性格で多くの人に愛されていますが、種類によって飼いやすさが大きく異なるため、選ぶ際にはしっかりとしたリサーチが必要です。愛情を持って世話をすることで、かけがえのないパートナーとしての関係が築けるでしょう。"
  category.difficulty = 2
  category.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shimaenaga.jpg"), filename:"shimaenaga.jpg")
end 

Category.find_or_create_by!(name: 'カワウソ') do |category|
  category.introduction =  "カワウソの魅力は、その遊び心満載の性格と愛らしい姿にあります。水中での敏捷な動きや、陸上での無邪気な振る舞いは、見ているだけで楽しい気分にさせてくれます。特に、仲間と遊ぶ姿や水中でのダイナミックな動きは、自然界の中でも特別な魅力を放っています。
                            飼いやすさについては、カワウソは非常に社交的で、群れで生活する動物です。そのため、単独飼育はストレスの原因となることがあります。できれば複数匹で飼うことが理想的ですが、それには広いスペースと適切な環境が必要です。また、カワウソは水を好むため、飼育環境には水槽やプールが必要になります。
                            食事は肉食性で、魚や小さな甲殻類が主な食べ物です。新鮮な食材を用意する必要があり、食事の準備や管理には手間がかかることがあります。さらに、活動的な性格から、十分な運動と刺激を提供することが大切です。
                            カワウソは非常に知能が高く、トリックを覚えたり、遊び道具で遊ぶことが好きです。これにより、飼い主とのインタラクションが豊かになり、飼育する楽しさが増します。ただし、その高いエネルギーと社交性を満たすためには、時間と労力が必要です。
                            総じて、カワウソはその愛らしさと遊び心で多くの人を魅了しますが、飼うにはしっかりとした準備と環境が求められます。しっかりとした世話を通じて、特別な存在としてのカワウソとの絆を深めることができるでしょう。"
  category.difficulty = 3
  category.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kawauso.jpg"), filename:"kawauso.jpg")
end 

Category.find_or_create_by!(name: 'ヘビ') do |category|
  category.introduction = "蛇の魅力は多岐にわたります。まず、その神秘的な姿が挙げられます。滑らかな体や美しい模様は、見る者を引きつけます。また、蛇は多様な生息環境に適応しており、熱帯雨林から砂漠まで、さまざまな場所に生息しています。この適応能力は、彼らの進化の歴史を物語っています。
                           さらに、蛇はしばしば象徴的な存在として文化や神話に登場します。知恵や再生、変化を象徴することが多く、特に古代の神話や宗教において重要な役割を果たしています。
                           蛇の行動も魅力的です。彼らの捕食方法や移動の仕方は、非常に興味深い観察対象となります。例えば、じっと待ち伏せて獲物を狙う姿や、優雅に地面を這う動きは、自然界の美しさを感じさせます。"
  category.difficulty = 3
  category.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/snake.jpg"), filename:"snake.jpg")
end 

Category.find_or_create_by!(name: '馬') do |category|
  category.introduction = "馬の魅力は、優雅さや力強さ、そして人との深い結びつきにあります。まず、彼らの美しい姿勢や動きは、多くの人を魅了します。特に走る姿は壮観で、自然の中での自由な姿は見る者を感動させます。
                          また、馬は非常に知能が高く、感受性も豊かです。人間とのコミュニケーションを楽しむことができ、信頼関係を築くことで、より深い絆を感じられます。これは特に乗馬やトレーニングを通じて実感できる部分です。
                          飼いやすさについては、馬は手間がかかる動物でもあります。広いスペースや適切な飼育環境が必要で、定期的な運動や食事管理が欠かせません。しかし、その分、日々の世話や運動を通じて得られる充実感や、馬との絆はとても深いものになります。"
  category.difficulty = 4
  category.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/uma.jpg"), filename:"uma.jpg")
end 

Category.find_or_create_by!(name: 'ゴリラ') do |category|
  category.introduction = "ゴリラの魅力は、その壮大な存在感と知性、そして驚くべき社会性にあります。彼らは地球上で最も大きな霊長類であり、その力強さと優雅さは観察する者を引きつけます。特に、親子の絆や群れの中でのコミュニケーションは、深い感動を与えます。
                            ゴリラは非常に知能が高く、道具を使ったり、問題解決をしたりする能力を持っています。これにより、彼らの行動や思考を理解する楽しさがあります。また、ゴリラは感情豊かで、人間の表情や感情に似た反応を示すことがあります。これが、彼らとの関係をより深める要素となります。
                            飼いやすさについては、ゴリラは野生動物であり、一般的にはペットとして飼うことは適切ではありません。彼らには広いスペース、適切な環境、そして社会的な刺激が必要です。群れで生活する動物であるため、孤独を感じやすく、十分な社会的交流がないとストレスを感じることがあります。
                            保護活動や教育プログラムでは、ゴリラの生態や保護の重要性を学ぶ機会が提供されています。彼らは絶滅危惧種に指定されており、その保護活動を通じて人々に影響を与える存在です。ゴリラの生息環境を守ることは、彼ら自身だけでなく、生態系全体のバランスを保つためにも重要です。
                            総じて、ゴリラはその知性、社会性、感情表現から多くの人にとって特別な存在です。彼らを理解し、保護することは、人間と自然との関係を見つめ直す良い機会となります。"
  category.difficulty = 5
  category.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/gorira.jpg"), filename:"gorira.jpg")
end 

tmp_user = User.find_or_create_by!(email: "12345@com") do |user|
  user.name = "サンプル"
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
  pet.age = 5
  pet.gender = 1
  pet.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/cat_g.jpg"), filename:"cat_g.jpg")
end

Pet.find_or_create_by!(name: 'サンプルペット2') do |pet|
  pet.user_id = tmp_user.id
  pet.category_id = tmp_category.id
  pet.age = 1
  pet.gender = 1
  pet.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kuroneko.jpg"), filename:"kuroneko.jpg")
  pet.need_help = 'true'
end

Album.find_or_create_by!(title: 'サンプル') do |album|
  album.pet_id = tmp_pet.id
  album.user_id = tmp_user.id
  album.body = 'サンプルです。'
  album.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/cat_g2.jpg"), filename:"cat_g2.jpg")
end

