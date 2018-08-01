# frozen_string_literal: true

require 'dry/container'

require 'lucid_intercom'

module LucidIntercom
  Container = Dry::Container.new

  # Services only (dependencies); no value objects, entities.
  Container.register(:convert) { Convert.new }
  Container.register(:post_request) { PostRequest.new }
  Container.register(:render_snippet) { RenderSnippet.new }
  Container.register(:send_event) { SendEvent.new }
  Container.register(:update_user) { UpdateUser.new }
end
