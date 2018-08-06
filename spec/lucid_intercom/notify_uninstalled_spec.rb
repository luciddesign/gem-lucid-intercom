# frozen_string_literal: true

module LucidIntercom
  RSpec.describe NotifyUninstalled do
    let(:post_request) { instance_double('PostRequest') }
    let(:update_user) { instance_double('UpdateUser') }

    subject(:event) do
      NotifyUninstalled.new(
        post_request: post_request,
        update_user: update_user
      )
    end

    include_fixtures 'shopify_data.yml'

    it_behaves_like 'event', :uninstalled
  end
end
