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
        response_body['responses'][0]['labelAnnotations'].pluck('description').take(3)
      end
    end
    
    
    # def translate_labels_to_japanese(labels)
    #   # グーグルクラウドTranstationAPIの初期化
    #     translate = Google::Cloud::Translate.translation_v2_service(
    #       project_id: ENV['GOOGLE_PROJECT_ID']
    #     )
    #   #翻訳
    #   translated_labels = labels.map do |label|
    #     translation = translate.translate label, to: 'ja'
    #     translation.text
    #   end
    #   translated_labels
    # end
  end
end
