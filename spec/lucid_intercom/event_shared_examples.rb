# frozen_string_literal: true

module LucidIntercom
  RSpec.shared_examples 'event' do |name, *args, **metadata|
    describe '#notify' do
      before do
        allow(post_request).to receive(:call) { Response.new(200, {}, '{}') } # for #assert!
        allow(update_user).to receive(:call)
      end

      it 'posts the event data' do
        expect(post_request).to receive(:call) do |path, data|
          expect(path).to eq('events')
          expect(data).to include(
            created_at: within(1).of(Time.now.utc.to_i),
            email: shopify_data['email'],
            event_name: "fake_#{name}",
            metadata: a_hash_including(
              company_id: shopify_data['myshopify_domain'],
              **metadata
            )
          )

          Response.new(200, {}, '{}') # for #assert!
        end

        event.notify(shopify_data, *args)
      end

      it 'updates the user' do
        expect(update_user).to receive(:call) do |user|
          expect(user).to be_a(UserAttributes)
        end

        event.notify(shopify_data, 'free')
      end
    end
  end
end
