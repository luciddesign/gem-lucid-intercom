# frozen_string_literal: true

module LucidIntercom
  RSpec.describe PostRequest do
    it 'returns a response' do
      http = double
      http_response = double(code: 200)
      allow(http).to receive_message_chain(:headers, post: http_response)

      res = PostRequest.new(http: http).('fake/path', fake: 'param')

      expect(res.status_code).to be(200)
    end
  end
end
