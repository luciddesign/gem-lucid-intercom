lucid_intercom
==============

Installation
------------

Add the gem to your ‘Gemfile’:

    gem 'lucid_intercom'


Usage
-----

### Configure the default API credentials

    LucidIntercom.config = LucidIntercom::Config.new(
      '...', # access_token
      '...', # secret
      '...', # app_id
      '...'  # app_prefix
    )

Here, ‘app_prefix’ is the snakecased app name, e.g. ‘smart_order_tags’


### Render the browser snippet

    LucidIntercom::RenderSnippet.new.(shopify_data, app_data)

This returns an HTML string which you can use in your view layout.

See the source code for documentation of arguments.


### Send an event

When a user installs/uninstalls the app, or changes their plan:

    event = LucidIntercom::InstalledEvent.new(shopify_data, new_plan)
    event = LucidIntercom::UninstalledEvent.new(shopify_data)
    event = LucidIntercom::ChangedPlanEvent.new(shopify_data, new_plan)

    LucidIntercom::SendEvent.new.(event)

Note that the `shopify_data` hash for uninstalled events cannot be
read from the API (as the access token is invalid at this stage).
You should use the data hash provided with Shopify’s ‘app/uninstalled’
webhook instead.


### Plan names

For installed apps, yet to subscribe to a plan, use ‘pending’.

For apps with a single paid plan, use ‘subscribed’.

For free apps, use ‘free’.

For partner-friendly app installs, use ‘partner’.


### Custom events

To define a custom event, subclass `LucidIntercom::Event`. See the
source code for documentation.
