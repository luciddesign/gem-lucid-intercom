# frozen_string_literal: true

require 'dry/initializer'

module LucidIntercom
  autoload :Attributes, 'lucid_intercom/attributes.rb'
  autoload :ChangedPlanEvent, 'lucid_intercom/changed_plan_event.rb'
  autoload :CompanyAttributes, 'lucid_intercom/company_attributes.rb'
  autoload :CompanyCustomAttributes, 'lucid_intercom/company_custom_attributes.rb'
  autoload :Config, 'lucid_intercom/config.rb'
  autoload :Container, 'lucid_intercom/container.rb'
  autoload :Convert, 'lucid_intercom/convert.rb'
  autoload :Error, 'lucid_intercom/error.rb'
  autoload :Event, 'lucid_intercom/event.rb'
  autoload :InstalledEvent, 'lucid_intercom/installed_event.rb'
  autoload :PostRequest, 'lucid_intercom/post_request.rb'
  autoload :RenderSnippet, 'lucid_intercom/render_snippet.rb'
  autoload :Response, 'lucid_intercom/response.rb'
  autoload :SendEvent, 'lucid_intercom/send_event.rb'
  autoload :UninstalledEvent, 'lucid_intercom/uninstalled_event.rb'
  autoload :UpdateUser, 'lucid_intercom/update_user.rb'
  autoload :UserAttributes, 'lucid_intercom/user_attributes.rb'
  autoload :VERSION, 'lucid_intercom/version.rb'
end
