# frozen_string_literal: true

require 'dry/container'
require 'http'

require 'lucid_intercom'

module LucidIntercom
  Container = Dry::Container.new

  # Services only (dependencies); no value objects, entities.
  Container.register(:convert) { Convert.new }
  Container.register(:http) { ::HTTP::Client.new }
  Container.register(:notify_changed_plan) { NotifyChangedPlan.new }
  Container.register(:notify_installed) { NotifyInstalled.new }
  Container.register(:notify_uninstalled) { NotifyUninstalled.new }
  Container.register(:post_request) { PostRequest.new }
  Container.register(:render_snippet) { RenderSnippet.new }
  Container.register(:update_user) { UpdateUser.new }
end
