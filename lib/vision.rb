require 'base64'
require 'json'
require 'net/https'
require 'google-cloud-translate'

module Vision
  class << self
    def get_image_date(image_file)
      #APIのURLさくせい
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"
      
      #画像をbase64にエンコード
      base64_image = Base64.encode64(image_file.download)
      
      #APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'LABEL_DETECTION'
            }
          ],
          imageContext:{
            languageHints:['ja']#日本語指定
          }
        }]
      }.to_json
      
      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      response_body = JSON.parse(response.body)
      
      # APIレスポンス出力
      if (error = response_body['responses'][0]['error']).present?
        raise error['message']
      else
        # english_labels = response_body['responses'][0]['labelAnnotations'].pluck('description').take(5)
        # translate_labels_to_japanese(english_labels)
        labels = response_body['responses'][0]['labelAnnotations'].pluck('description').take(3)
        translate_labels_to_japanese(labels)
      end
    end
    
    
    def translate_labels_to_japanese(labels)

      #配列で送られてきたlabelsをカンマで区切って１つの文字列化
      label_str = labels.join(",")
      #送り先uriはどこかの指定
      url = URI.parse('https://translation.googleapis.com/language/translate/v2')
      #qに送る文章 sourceは元の言語 targetは翻訳後の言語　それとキーをparamsに格納
      params = { q: label_str, source: 'en', target: 'ja', key: "#{ENV['GOOGLE_TRANSLATE_API_KEY']}" } 
      #先ほど指定したurlにparamsをクエリパラメータの形式にエンコード(encode_www_formの部分)して代入
      url.query = URI.encode_www_form(params)
      #resにネットにHTTPリクエスト(urlを提供し)サーバーからのレスポンス(返事)を取得する
      res = Net::HTTP.get_response(url)
      #JSON形式でres.bodyが返ってきている想定でparse(解析)して配列やハッシュとして扱えるように
      #解析されたハッシュの中からdataキーとその中のtranslationsキーにアクセスし最初の１件(first)を取得
      #['translatedText']: 最初の翻訳結果の中から、translatedTextというキーにアクセスし、実際の翻訳されたテキストを取得します。
      result = JSON.parse(res.body)['data']['translations'].first['translatedText']
      #resultに、を入れて配列化
      result.split("、")
    end
  end
end
