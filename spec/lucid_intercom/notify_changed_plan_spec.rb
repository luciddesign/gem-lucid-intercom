# frozen_string_literal: true

require_relative 'event_shared_examples'

module LucidIntercom
  RSpec.describe NotifyChangedPlan do
    let(:post_request) { instance_double('PostRequest') }
    let(:update_user) { instance_double('UpdateUser') }

    subject(:event) do
      NotifyChangedPlan.new(
        post_request: post_request,
        update_user: update_user
      )
    end

    include_fixtures 'shopify_data.yml'

    it_behaves_like 'event', :changed_plan, 'plus', new_plan: 'plus'
  end
end
