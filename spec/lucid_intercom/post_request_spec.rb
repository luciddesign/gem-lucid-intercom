# frozen_string_literal: true

require 'lucid_intercom/post_request'

module LucidIntercom
  RSpec.describe PostRequest do
    subject(:post_request) { PostRequest.new }

    it 'returns a response' do
      http = double
      http_response = double(code: 200)
      allow(http).to receive_message_chain(:headers, post: http_response)
      stub_const('HTTP', http)

      res = post_request.('fake/path', fake: 'param')

      expect(res.status_code).to be(200)
    end
  end
end
