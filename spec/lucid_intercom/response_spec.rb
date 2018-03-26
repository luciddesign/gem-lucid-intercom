# frozen_string_literal: true

require 'lucid_intercom/response'

RSpec.describe LucidIntercom::Response do
  let(:status_code) { 200 }

  subject(:response) { LucidIntercom::Response.new(status_code) }

  it { is_expected.to have_attributes(status_code: status_code) }

  shared_examples 'status code' do |range, error_class|
    context "when status code is within #{range}" do
      let(:status_code) { rand(range) }

      it 'raises an error on #assert!' do
        expect { response.assert! }.to raise_error do |error|
          expect(error).to be_a(error_class)
          expect(error.message).to eq("bad response (#{status_code})")
          expect(error.status_code).to be(status_code)
        end
      end
    end
  end

  include_examples 'status code', 400..499, LucidIntercom::Response::ClientError
  include_examples 'status code', 500..599, LucidIntercom::Response::ServerError

  context 'with a success status code' do
    let(:status_code) { rand(200..299) }

    it 'assert! is true' do
      expect(response.assert!).to be(true)
    end
  end
end
